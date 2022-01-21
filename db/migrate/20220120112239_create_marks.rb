class CreateMarks < ActiveRecord::Migration[6.1]
  def change
    create_table :marks do |t|
      t.belongs_to :student
      t.string :name
      t.integer :mark, null: false

      t.timestamps
    end
  end
end
