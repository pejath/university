class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  ROLES = { "admin_id" => 0, "lecturer_id" => 1, "methodist_id" => 2, "student_id" => 3 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :invitation_token, foreign_key: :token, primary_key: :token
  after_create :set_role

  def set_role
    find_role = InvitationToken.select(:lecturer_id, :student_id, :admin_id, :methodist_id)
                               .find_by(token: token).attributes&.compact&.keys
    self.role = ROLES[find_role[0]]
    save!
  end

  def owner
    invitation_token.owner
  end

  def is_admin?
    true if role.zero?
  end

  def is_lecturer?
    true if role == 1
  end

  def is_methodist?
    true if role == 2
  end

  def is_student?
    true if role == 3
  end
end
