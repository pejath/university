class AddFormationDateToDepartment < ActiveRecord::Migration[6.1]
  def change
    add_column :departments, :formation_date, :date
  end
end
