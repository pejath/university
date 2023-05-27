# frozen_string_literal: true

class UsersController < ApplicationController
  # ROLES = { "admin_id" => 0, "lecturer_id" => 1, "methodist_id" => 2, "student_id" => 3 }

  def profile
    case current_user.role
    when 0
      puts 0
    when 1
      @lecturer = 'lecturer profile'
      render view_for_user('lecturer')
    when 2
      @methodist = 'methodist profile'
      render view_for_user('methodist')
    when 3
      @student = 'student profile'
      render view_for_user('student')
    else
      # type code here
    end
  end

  private

  def view_for_user(name)
    "#{name}_profile"
  end
end
