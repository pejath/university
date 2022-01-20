class Mark < ApplicationRecord
  # enum mark: %w[1 2 3 4 5]
  belongs_to :student
  validates :mark, numericality: {only_integer: true, greater_than: 1, less_or_equal_then:5}
end
