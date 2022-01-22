class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.belongs_to :faculty
      t.string :name, null: false
      t.string :department_type, null: false
      t.date :formation_date, null: false

      t.timestamps
    end
  end
end
