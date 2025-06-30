class User < ApplicationRecord
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

end
