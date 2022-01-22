class Group < ApplicationRecord
  enum form_of_education: {evening: 0, correspondence: 1, full_time: 2}
  belongs_to :faculty
  belongs_to :lecturer
  has_many :lectures
  has_many :lecturers, through: :lectures
  has_many :subjects

  validates :specialization_code,presence: true, numericality: {only_integer: true}, uniqueness: true
  validates :course, presence: true, numericality: {only_integer: true, greater_than: 0, less_than:6}



end
