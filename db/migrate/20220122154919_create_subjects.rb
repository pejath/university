class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.belongs_to :lecturer
      t.string :name, null: false
      t.integer :code, null: false, uniq: true

      t.timestamps
    end
  end
end
