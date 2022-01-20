class Student < ApplicationRecord
  belongs_to :group
  has_many :marks

  validates :name, presence: true

  scope :average_mark, ->(id) {Mark.where('student_id = ?', id).average('mark').to_f.round(2)}

end