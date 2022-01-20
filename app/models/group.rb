class Group < ApplicationRecord
  enum form_of_education: %w[evening correspondence full-time]
  has_many :lectures
  has_one :curator
  has_many :lecturers, through: :lectures
  belongs_to :faculty

  validates :specialization_code, numericality: {only_integer: true}, uniqueness: true
  validates :course, numericality: {only_integer: true, greater_than: 0, less_than:6}



end
