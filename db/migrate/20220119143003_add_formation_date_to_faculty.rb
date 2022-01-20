class AddFormationDateToFaculty < ActiveRecord::Migration[6.1]
  def change
    add_column :faculties, :formation_date, :date
  end
end
