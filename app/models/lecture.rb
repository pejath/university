class Lecture < ApplicationRecord
  enum weekday: {Monday: 0, Tuesday: 1, Wednesday: 2, Thursday: 3, Friday: 4, Saturday: 5}
  belongs_to :group
  belongs_to :lecture_time
  belongs_to :lecturer
  belongs_to :subject

  validates :auditorium, numericality: {only_integer: true}, presence: true, uniqueness: { scope: %i[corpus lecture_time_id ]}
  validates :group_id, :lecturer_id, presence: true, uniqueness: {scope: %i[lecture_time_id weekday]}
  validates :corpus, presence: true
end
