class Group < ApplicationRecord
  has_many :lectures

  has_many :lecturers, through: :lectures
  belongs_to :faculty

  validates :specialization_code, numericality: {only_integer: true}, uniqueness: true
  validates :course, numericality: {only_integer: true, greater_than: 0, less_than:6}
  validates :form_of_education, inclusion: {in: %w[full-time evening correspondence] }



end
