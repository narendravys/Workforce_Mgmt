class User < ApplicationRecord

  has_one_attached :photo
  has_secure_password
  has_one :employee, class_name: "Employee", foreign_key: :user_id
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  enum role: {
      super_admin: 0,
      admin: 1,
      hr: 2,
      manager: 3,
      team_lead: 4,
      developer: 5,
      qa_engineer: 6,
      ui_ux_designer: 7,
      devops_engineer: 8,
      intern: 9,
      finance: 10,
      product_owner: 11,
      business_analyst: 12,
      support_engineer: 13,
      sales: 14
  }

  belongs_to :manager, class_name: 'User', optional: true, foreign_key: 'manager_id'

  has_many :subordinates, class_name: 'User', foreign_key: 'manager_id'

  has_many :team_leads, -> { where(role: 'team_lead') }, class_name: 'User', foreign_key: 'manager_id'
  has_many :developers, -> { where(role: 'developer') }, class_name: 'User', foreign_key: 'manager_id'


  def accessible_users
    case role.to_sym
    when :super_admin, :admin, :hr
        User.all
    when :manager
        team_leads_ids = subordinates.where(role: :team_lead).pluck(:id)
        User.where(manager_id: team_leads_ids).or(subordinates.where(role: :team_lead))
    when :team_lead
        subordinates.where(role: [:developer, :qa_engineer])
    else
        User.none
    end
  end
end
