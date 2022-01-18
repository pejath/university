class Student < ApplicationRecord
  belongs_to :group

  validates :name, presence: true
  validates :average_mark, numericality: {minimum: 1, maximum: 5}

  scope :excellent_students, -> { where('average_mark>=4') }
  scope :red_diplomas, -> {Student.joins(:group).where('average_mark>=4.5', 'course = 5')}
end
