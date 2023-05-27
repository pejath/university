class GroupPolicy < ApplicationPolicy
  def show?
    true
  end

  def journal?
    if user.is_student?
      return scope.id == user.owner.group_id
    end
    user.is_admin? || user.is_lecturer?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
