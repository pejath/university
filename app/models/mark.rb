class Mark < ApplicationRecord
  belongs_to :lecturer
  belongs_to :student
  belongs_to :subject
  validates :mark, numericality: {only_integer: true, greater_than_or_equal_then: 1, less_or_equal_then:5}, presence: true
end
