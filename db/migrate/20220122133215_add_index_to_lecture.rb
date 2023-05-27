# frozen_string_literal: true

class AddIndexToLecture < ActiveRecord::Migration[6.1]
  def change
    add_index :lectures, %i[corpus auditorium lecture_time_id group_id lecturer_id weekday], unique: true,
                                                                                             name: 'lecture_index'
    # add_index :lectures, %i[group_id lecturer_id], unique: true
  end
end
