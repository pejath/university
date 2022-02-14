class Subject < ApplicationRecord
  has_and_belongs_to_many :lecturer, through: :lectures_subject
  has_many :marks
  has_many :students, through: :marks
  has_many :groups

  validates :name, presence: true, uniqueness: true
end
