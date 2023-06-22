# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_dates
  # ROLES = { "admin_id" => 0, "lecturer_id" => 1, "methodist_id" => 2, "student_id" => 3 }

  def profile
    case current_user.role
    when 1
      @lecturer = current_user.owner
      @lectures = @lecturer.lectures
      @grouped_lectures = @lectures.includes(:lecture_time).order('weekday').order('lecture_times.beginning').group_by(&:weekday)
      @group = if params[:group_id]
                 Group.find(params[:group_id])
               else
                 @lecturer.curatorial_group ? @lecturer.curatorial_group : Group.first
               end

      @students = @group.students
      @subjects = @group.subjects.uniq
      @subject = Subject.where(id: params[:subject_id])

      @subject = @group.subjects.first if @subject.nil?

      @marks = {}
      @students.each do |student|
        @marks[student] = {}
        @dates.each do |date|
          mark = student.marks.where(created_at: date.beginning_of_day, subject_id: @subject).first
          @marks[student][date] = mark if mark
        end
      end


      render view_for_user('lecturer')
    when 3
      @student = current_user.owner
      @group = @student.group
      @lectures = @group.lectures
      @grouped_lectures = @lectures.includes(:lecture_time).order('weekday').order('lecture_times.beginning').group_by(&:weekday)
      @subjects = @group.subjects.group(:subject_id)
      @marks = {}
      @subjects.each do |subject|
        @marks[subject.name] = {}
        @dates.each do |date|
          mark = @student.marks.where(created_at: date.beginning_of_day, subject_id: subject).first
          @marks[subject.name][date] = mark if mark
        end
      end

      render view_for_user('student')
    else
      redirect_to :root
    end
  end

  private

  def set_dates
    if ("1"..'12').include? params[:month_id]
      @month = Date.new(Date.today.year, params[:month_id].to_i)
    else
      @month = Date.today
    end
    @dates = (@month.beginning_of_month..@month.end_of_month)
  end
  def view_for_user(name)
    "#{name}_profile"
  end

  def student_params
    params.permit(:month_id, :group_id, :subject_id)
  end
end
