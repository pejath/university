class InvitationToken < ApplicationRecord
  has_one :user, dependent: :destroy

end
