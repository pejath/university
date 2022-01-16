class CreateFormationDates < ActiveRecord::Migration[6.1]
  def change
    create_table :formation_dates do |t|
      t.date :formation_date
      t.references :formed, polymorphic: true, null: false

      t.timestamps
    end
  end
end
