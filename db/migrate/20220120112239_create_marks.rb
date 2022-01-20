class CreateMarks < ActiveRecord::Migration[6.1]
  def change
    create_table :marks do |t|
      t.belongs_to :student
      t.string :name
      t.integer :mark

      t.timestamps
    end
  end
end
