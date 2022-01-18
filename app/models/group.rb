class Group < ApplicationRecord
  has_and_belongs_to_many :lectures
  has_one :lecturer
  belongs_to :faculty

  validates :specialization_code, numericality: {only_integer: true}, uniqueness: true
  validates :course, numericality: {only_integer: true, minimum:1, maximum:5}
  validates :form_of_education, inclusion: {in: %w[full-time evening correspondence] }



end
