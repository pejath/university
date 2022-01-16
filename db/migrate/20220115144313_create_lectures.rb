class CreateLectures < ActiveRecord::Migration[6.1]
  def change
    create_table :lectures do |t|
      t.integer :corpus
      t.integer :auditorium

      t.timestamps
    end
  end
end
