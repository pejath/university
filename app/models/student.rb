class Student < ApplicationRecord
  belongs_to :group
  has_many :marks
  has_many :subjects, through: :marks



  validates :name, presence: true

  #It sucks :/
  scope :red_diplomas, -> {
                         Student.select { |student|
    (student.average_mark > 4.5) && (Group.find(student.group_id).course == 5)
  }}

  def average_mark
    Mark.where('student_id = ?', id).average('mark').to_f.round(2)
  end
end