class Mark < ApplicationRecord
  belongs_to :lecturer
  belongs_to :student
  belongs_to :subject

  validate :subject_lecturer
  validates :mark, numericality: {only_integer: true, greater_than_or_equal_then: 1, less_or_equal_then:5}, presence: true

  def subject_lecturer
    unless Subject.exists?(id: subject_id, lecturer_id: lecturer_id)
      errors.add(:lecturer, "doesn't have such subject")
    end
  end
end
