class InvitationToken < ApplicationRecord
  belongs_to :student, optional: true
  belongs_to :methodist, optional: true
  belongs_to :lecturer, optional: true
  belongs_to :admin, optional: true

  has_one :user, foreign_key: :token, primary_key: :token, dependent: :destroy

  def owner
    return student if student
    return methodist if methodist
    return lecturer if lecturer
    admin if admin
  end
end
