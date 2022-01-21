class Department < ApplicationRecord
  enum department_type: %i[Interfacult Basic Military]
  belongs_to :faculty
  has_many :lecturers

  validates :name, presence: true
  validates :formation_date, presence: true
  validates_format_of :formation_date, with: /\A\d{0,4}.\d{0,2}.\d{0,2}\z/
end
