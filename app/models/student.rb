# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :group
  has_many :marks, dependent: :destroy
  has_many :subjects, through: :marks
  has_many :lectures, through: :group
  has_one :department, through: :group
  has_one :invitation_token, dependent: :destroy

  accepts_nested_attributes_for :marks, allow_destroy: true

  after_create :create_invitation_token

  validates :name, presence: true

  scope :red_diplomas, lambda {
                         Student.joins(:marks, :group).group(:id).having('AVG(marks.mark) >= 4.5').where('groups.course = 5')
                       }

  def average_mark(*subject)
    if subject
      Mark.where('student_id = ? and subject_id = ?', id, Subject.find_by(name: subject[0])).average('mark').to_f.round(2)
    else
      Mark.where('student_id = ?', id).average('mark').to_f.round(2)
    end
  end

  def create_invitation_token
    InvitationToken.create(student_id: id, token: SecureRandom.urlsafe_base64(6, false))
  end
end
