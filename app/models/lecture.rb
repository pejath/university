class Lecture < ApplicationRecord
  belongs_to :group
  belongs_to :lecture_time
  belongs_to :lecturer

  validate :possible
  validate :free_audience
  validates :auditorium, :corpus, numericality: {only_integer: true}, presence: true


  def free_audience
    if Lecture.where(auditorium: auditorium, corpus: corpus).exists?(lecture_time_id: lecture_time_id)
      errors.add(:lecture_time_id, 'Auditorium will be occupied in this time')
    end
  end

  def possible
    if Lecture.exists?(group_id: group_id, lecture_time_id: lecture_time_id)
      errors.add(:group_id, 'already has a lecture')
    end
    if Lecture.exists?(lecturer_id: lecturer_id, lecture_time_id: lecture_time_id)
      errors.add(:lecturer, 'already has a lecture')
    end
  end

end
