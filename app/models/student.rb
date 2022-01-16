class Student < ApplicationRecord
  belongs_to :group

  validates :name, presence: true
  validates :average_mark, numericality: {minimum: 1, maximum: 2}
end
