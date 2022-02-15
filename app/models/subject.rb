class Subject < ApplicationRecord
  has_many :lecturers_subjects
  has_many :lecturer, through: :lecturers_subjects
  has_many :marks
  has_many :students, through: :marks
  has_many :groups

  validates :name, presence: true, uniqueness: true
end
