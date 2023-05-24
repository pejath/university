class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  ROLES = { "admin_id" => 0, "lecturer_id" => 1, "methodist_id" => 2, "student_id" => 3 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # after_create :set_role

  def set_role
    pry
    find_role = InvitationToken.select(:lecturer_id, :student_id, :admin_id, :methodist_id)
                               .find_by(token: invitation_token).attributes.compact.keys
    self.role = ROLES[find_role[0]]
    save!
  end
end
