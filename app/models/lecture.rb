class Lecture < ApplicationRecord
  belongs_to :group
  belongs_to :lecture_time
  belongs_to :lecturer

  validates :auditorium, numericality: {only_integer: true}, presence: true, uniqueness: { scope: %i[corpus lecture_time_id]}
  validates :group_id, :lecturer_id, presence: true, uniqueness: {scope: :lecture_time_id}

end
