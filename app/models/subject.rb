class Subject < ApplicationRecord
  belongs_to :lecturer
  has_many :marks
  has_many :students, through: :marks
  has_many :groups

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
