class AddIndexToLecture < ActiveRecord::Migration[6.1]
  def change
    add_index :lectures, %i[corpus auditorium lecture_time_id], unique: true
    add_index :lectures, %i[group_id lecturer_id], unique: true
  end
end
