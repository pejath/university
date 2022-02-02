class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]

  def show
  end

  def new
    @students = Student.new
  end

  def edit
  end

  def create
    @students = Student.new(student_params)
    @students.save
  end

  def update
  end

  def destroy
    @students.destroy

  end

  def red_diplomas
    @students = Student.red_diplomas
    @groups_id = Group.select(:id)
    @marks = Mark.all
  end

  def journal
    params.permit(:group)
    @students = if params.key?(:group)
                  Student.where(group_id: params[:group])
                else
                  Student.all
                end
    @groups_id = Group.select(:id)
    @marks = Mark.all
  end

  private

  def set_student
    @students = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:group_id, :name)
  end
end
