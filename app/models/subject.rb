class Subject < ApplicationRecord
  has_many :lecturers_subjects
  has_many :lecturers, through: :lecturers_subjects
  has_many :marks, dependent: :delete_all
  has_many :students, through: :marks
  has_many :groups

  validates :name, presence: true, uniqueness: true
end
