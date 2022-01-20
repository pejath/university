class Lecturer < ApplicationRecord
  belongs_to :department
  has_many :lectures
  has_one :curator
  has_many :groups, through: :lectures

  validates :name, presence: true
  validates :academic_degree, numericality: {only_integer: true, greater_than: 0, less_than:6}


end
