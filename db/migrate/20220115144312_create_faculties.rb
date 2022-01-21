class CreateFaculties < ActiveRecord::Migration[6.1]
  def change
    create_table :faculties do |t|
      t.string :name, null: false, index: true

      t.timestamps
    end
  end
end
