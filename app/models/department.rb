class Department < ApplicationRecord
  belongs_to :faculty
  has_many :lecturers
  has_one :formation_date

  validates :name, presence: true
  validates :department_type, inclusion: {in: %w(Interfacult Basic Military)}
end
