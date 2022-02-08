class AddIndexToLecturersSubjects < ActiveRecord::Migration[6.1]
  def change
    add_index :lecturers_subjects, [ :lecturer_id, :subject_id ], :unique => true
  end
end
