class Group < ApplicationRecord
  enum form_of_education: {evening: 0, correspondence: 1, full_time: 2}
  belongs_to :faculty
  belongs_to :curator, class_name: 'Lecturer', foreign_key: :curator_id
  has_many :lectures
  has_many :lecturers, through: :lectures
  has_many :subjects

  validates :form_of_education, inclusion: {in: %w[evening correspondence full_time], message: 'is not valid form'}
  validates :specialization_code, :curator_id, presence: true, numericality: {only_integer: true}, uniqueness: true
  validates :course, presence: true, numericality: {only_integer: true, greater_than: 0, less_than:6}

  def form_of_education=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value('form_of_education', value)
  end
end
