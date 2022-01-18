class Lecture < ApplicationRecord
  has_and_belongs_to_many :groups
  belongs_to :lecture_time
  has_one :lecturer

  validate :free_audience
  validates :auditorium, numericality: {only_integer: true}
  validates :corpus, numericality: {only_integer: true}

  def free_audience
    if Lecture.where(auditorium: auditorium).exists?(lecture_time_id: lecture_time_id)
      errors.add(:lecture_time_id, 'auditorium will be occupied')
    end
  end

end
