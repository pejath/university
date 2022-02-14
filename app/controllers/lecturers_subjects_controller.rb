class LecturersSubjectsController < ApplicationController
  include LecturersSubjectsHelper
  before_action :set_lecturer_and_subject
  before_action :set_lecturers_subject, only: %i[ show edit update destroy ]

  # GET /lecturers_subjects or /lecturers_subjects.json
  def index
    @lecturers_subjects = LecturersSubject.all
  end

  # GET /lecturers_subjects/1 or /lecturers_subjects/1.json
  def show
  end

  # GET /lecturers_subjects/new
  def new
    @lecturers_subject = LecturersSubject.new
  end

  # GET /lecturers_subjects/1/edit
  def edit; end

  # POST /lecturers_subjects or /lecturers_subjects.json
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

  # PATCH/PUT /lecturers_subjects/1 or /lecturers_subjects/1.json
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

  # DELETE /lecturers_subjects/1 or /lecturers_subjects/1.json
  def destroy
    @lecturers_subject.destroy

    respond_to do |format|
      format.html { redirect_to lecturers_subjects_url, notice: "Lecturers subject was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
  def set_lecturers_subject
    @lecturers_subject = LecturersSubject.find(params[:id])
  end

  def set_lecturer_and_subject
    @subject = Subject.all
    @lecturer = Lecturer.all
  end

    # Only allow a list of trusted parameters through.
  def lecturers_subject_params
    params.require(:lecturers_subject).permit(:subject_id, :lecturer_id)
  end
end
