class Department < ApplicationRecord
  enum department_type: %w(Interfacult Basic Military)
  belongs_to :faculty
  has_many :lecturers

  validates :name, presence: true
  validates :department_type, inclusion: {in: %w(Interfacult Basic Military)}
end
