class Employee < ApplicationRecord
    enum employment_type: { full_time: 0, part_time: 1, contract: 2, intern: 3, freelance: 4 }
    enum status: { active: 0, on_leave: 1, resigned: 2, terminated: 3 }
end
