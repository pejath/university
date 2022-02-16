class Lecturer < ApplicationRecord
  belongs_to :department
  has_many :lectures
  has_many :subjects
  has_many :marks, through: :subjects, dependent: :nullify
  has_one :curatorial_group, class_name: 'Group', foreign_key: :curator_id
  has_many :groups, through: :lectures

  validates :name, presence: true
  validates :academic_degree, numericality: {only_integer: true, greater_than: 0, less_than:6}, allow_blank: true


end
