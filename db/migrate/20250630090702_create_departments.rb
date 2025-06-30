class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments do |t|
      t.string :name, null: false
      t.text :description
      t.string :code, null: false 

      t.timestamps
    end

    add_index :departments, :name, unique: true
    add_index :departments, :code, unique: true
  end
end
