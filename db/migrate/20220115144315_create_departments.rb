class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.belongs_to :faculty
      t.string :name
      t.string :department_type

      t.timestamps
    end
  end
end
