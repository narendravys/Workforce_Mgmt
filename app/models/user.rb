class User < ApplicationRecord

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
end
