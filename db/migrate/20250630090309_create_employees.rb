class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.references :user, foreign_key: true, null: true
      t.references :department, null: false, foreign_key: true
      t.string :employee_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :phone
      t.date :dob
      t.date :hire_date, null: false
      t.string :position, null: false
      t.integer :employment_type, null: false, default: 0  
      t.integer :status, null: false, default: 0           
      t.text :address
      t.decimal :salary, precision: 10, scale: 2
      t.references :reporting_manager, foreign_key: { to_table: :employees }, null: true

      t.timestamps
    end

    add_index :employees, :employee_id, unique: true
  end
end
