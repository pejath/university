class Lecture < ApplicationRecord
  belongs_to :group
  belongs_to :lecture_time
  belongs_to :lecturer

  validates :auditorium, numericality: {only_integer: true}, presence: true, uniqueness: { scope: %i[corpus lecture_time_id lecturer_id group_id]}
  validates :group_id, :lecturer_id, presence: true, uniqueness: {scope: %i[lecture_time_id]}

end
