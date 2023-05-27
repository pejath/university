# frozen_string_literal: true

class StudentPolicy < ApplicationPolicy
  def edit?
    user.is_lecturer? || user.is_admin?
  end

  def index?
    user.is_admin? || user.is_lecturer?
  end

  def show?
    !user.is_methodist?
  end

  def update?
    user.is_admin? || user.is_lecturer?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   nil
    # end
  end
end
