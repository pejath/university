class LecturersSubjectsController < ApplicationController
  include LecturersSubjectsHelper
  before_action :set_lecturer_and_subject, only: %i[new create]
  before_action :set_ls, only: :destroy

  def index
    @lecturers_subjects = LecturersSubject.all
  end

  def show; end

  def new
    @lecturers_subject = LecturersSubject.new
  end

  def edit; end

  def create
    @lecturers_subject = LecturersSubject.new(lecturers_subject_params)

    respond_to do |format|
      if @lecturers_subject.save
        format.html { redirect_to lecturers_path, notice: "Data was successfully created." }
        format.json { render :show, status: :created, location: @lecturers_subject }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lecturers_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lecturers_subject.update(lecturers_subject_params)
        format.html { redirect_to lecturers_path, notice: "Data was successfully updated." }
        format.json { render :show, status: :ok, location: @lecturers_subject }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lecturers_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    respond_to do |format|
      if @lecturers_subject.destroy
        format.html { redirect_to lecturers_path, notice: "Lecturers subject was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to lecturers_subjects_url, notice: "Something go wrong." }
      end
    end
  end

  private

  def set_lecturer_and_subject
    @subject = Subject.all
    @lecturer = Lecturer.all

  end

  def set_ls
    @lecturers_subject = LecturersSubject.find(params[:id])
  end

  def lecturers_subject_params
    params.require(:lecturers_subject).permit(:subject_id, :lecturer_id)
  end
end
