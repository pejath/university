class CreateLectureTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :lecture_times do |t|
      t.time :beginning, null: false

    end
  end
end
