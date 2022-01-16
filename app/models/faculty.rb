class Faculty < ApplicationRecord
  has_many :departments
  has_many :lecturers, through: :departments

  validates :name, presence: true, uniqueness: true
end
