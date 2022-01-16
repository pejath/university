class Lecture < ApplicationRecord
  has_and_belongs_to_many :groups

  validates :auditorium, numericality: {only_integer: true}
  validates :corpus, numericality: {only_integer: true}
end
