class StudentsController < ApplicationController
  include StudentsHelper
  before_action :set_student, only: %i[show edit update destroy]

  def show; end

  def new
    @student = Student.new
  end

  def edit; end

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to student_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def index
    @students = if params.key?(:red_diplomas)
                  red_diplomas(Student.all, params)
                else
                  filter_by_params(Student.all, params)
                end
    @marks = Mark.all
    @groups_id = Group.select(:id)
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:group_id, :name)
  end
end
