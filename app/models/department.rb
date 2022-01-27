class Department < ApplicationRecord
  enum department_type: { Interfacult: 0, Basic: 1, Military: 2}
  belongs_to :faculty
  has_many :lecturers

  validates :name, :formation_date, presence: true
  validates_format_of :formation_date, with: /\A\d{0,4}.\d{0,2}.\d{0,2}\z/
end
