# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :group
  has_many :marks, dependent: :destroy
  has_many :subjects, through: :marks
  has_one :invitation_token, dependent: :destroy

  accepts_nested_attributes_for :marks, allow_destroy: true

  after_create :create_invitation_token

  validates :name, presence: true

  scope :red_diplomas, lambda {
                         Student.joins(:marks, :group).group(:id).having('AVG(marks.mark) >= 4.5').where('groups.course = 5')
                       }

  def average_mark
    Mark.where('student_id = ?', id).average('mark').to_f.round(2)
  end

  def create_invitation_token
    InvitationToken.create(student_id: id, token: SecureRandom.urlsafe_base64(6, false))
  end
end
