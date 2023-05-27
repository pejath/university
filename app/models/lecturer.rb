# frozen_string_literal: true

class Lecturer < ApplicationRecord
  belongs_to :department
  has_many :lectures
  has_many :lecturers_subjects
  has_many :subjects, through: :lecturers_subjects
  has_many :marks, dependent: :nullify
  has_many :groups, through: :lectures
  has_one :invitation_token, dependent: :destroy
  has_one :curatorial_group, class_name: 'Group', foreign_key: :curator_id, dependent: :nullify

  validates :name, presence: true
  validates :academic_degree, numericality: { only_integer: true, greater_than: 0, less_than: 6 }, allow_blank: true

  after_create :create_invitation_token

  scope :free_curators, lambda { |group|
                          Lecturer.where.missing(:curatorial_group).or(Lecturer.where(curatorial_group: group))
                        }

  def create_invitation_token
    InvitationToken.create(lecturer_id: id, token: SecureRandom.urlsafe_base64(6, false))
  end
end
