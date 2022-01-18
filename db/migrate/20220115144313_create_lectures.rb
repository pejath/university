class CreateLectures < ActiveRecord::Migration[6.1]
  def change
    create_table :lectures do |t|
      t.belongs_to :lecture_time
      t.integer :corpus
      t.integer :auditorium

    end
  end
end
