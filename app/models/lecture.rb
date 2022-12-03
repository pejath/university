class Lecture < ApplicationRecord
  WEEKDAY = [%w[Monday Monday], %w[Tuesday Tuesday], %w[Wednesday Wednesday], %w[Thursday Thursday], %w[Friday Friday], %w[Saturday Saturday]]
  enum weekday: {Monday: 0, Tuesday: 1, Wednesday: 2, Thursday: 3, Friday: 4, Saturday: 5}
  belongs_to :group
  belongs_to :lecture_time
  belongs_to :lecturer
  belongs_to :subject
  validate :audit_num
  validates :weekday, inclusion: { in: %w[Monday Tuesday Wednesday Thursday Friday Saturday 0 1 2 3 4 5], message: 'is not valid form'}
  validates :auditorium, numericality: {only_integer: true, more_than_or_equal_to:1}, presence: true, uniqueness: { scope: %i[corpus lecture_time_id ]}
  validates :group_id, :lecturer_id, presence: true, uniqueness: {scope: %i[lecture_time_id weekday]}
  validates :corpus, presence: true, numericality: {only_integer: true}

  def audit_num
    if auditorium<=0
      errors.add(:auditorium, "can't be equal or less than zero" )
    end
  end
  def weekday=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value('weekday', value)
  end
end
