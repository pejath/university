class StudentsController < ApplicationController
  include StudentsHelper
  before_action :set_subject_and_lecturers, only: %i[show edit new create]
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

    respond_to do |format|
      if @student.destroy
        format.html { redirect_to students_path, notice: "Student was successfully destroyed." }
      else
        format.html { redirect_to students_url, notice: "Something went wrong."}
      end
    end
  end

  def index
    @students = filter_by_params(Student.all, filter_params)
    @marks = Mark.all
    @groups_id = Group.select(:id)
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def set_subject_and_lecturers
    @subjects = Subject.select(:id, :name)
    @lecturers = Lecturer.select(:id, :name)
  end

  def filter_params
    params.permit(:red_diplomas, :group_id)
    # params.require(:filter).permit(:group_id, :red_diplomas)
  end

  def student_params
    params.require(:student).permit(:group_id, :name, marks_attributes: %i[id mark subject_id lecturer_id _destroy])
  end
end
