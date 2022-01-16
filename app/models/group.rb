class Group < ApplicationRecord
  has_and_belongs_to_many :lectures

  validates :specialization_code, numericality: {only_integer: true}
  validates :course, numericality: {only_integer: true}
  validates :form_of_education, inclusion: {in: %w[full-time evening correspondence] }
end
