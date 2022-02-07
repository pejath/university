class LecturesController < ApplicationController
  before_action :get_group
  before_action :set_lecturers_subject_and_time, only: %i[edit new update create]
  before_action :set_lecture, only: %i[ show edit update destroy ]

  # GET /lectures or /lectures.json
  def index
    @lectures = @group.lectures.order(:lecture_time_id)
  end

  # GET /lectures/1 or /lectures/1.json
  def show
  end

  # GET /lectures/new
  def new
    @lecture = @group.lectures.build
  end

  # GET /lectures/1/edit
  def edit
  end

  # POST /lectures or /lectures.json
  def create
    @lecture = @group.lectures.build(lecture_params)

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to group_lectures_path, notice: "Lecture was successfully created." }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1 or /lectures/1.json
  def update
    respond_to do |format|
      if @group.lectures.build(lecture_params)
        format.html { redirect_to group_lecture_path, notice: "Lecture was successfully updated." }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1 or /lectures/1.json
  def destroy
    @lecture.destroy

    respond_to do |format|
      if @lecture.destroy
        format.html { redirect_to students_path, notice: "Lecture was successfully destroyed." }
      else
        format.html { redirect_to students_url, notice: "Something went wrong."}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

  def set_lecturers_subject_and_time
    @lecture_time = LectureTime.all
    @subject = Subject.all
    @lecturers = Lecturer.select(:id, :name)
  end
  def get_group
    @group = Group.find(params[:group_id])
  end

  def set_lecture
    @lecture = @group.lectures.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def lecture_params
    params.require(:lecture).permit(:lecture_time_id, :group_id, :lecturer_id, :subject_id, :weekday, :corpus, :auditorium, {})
  end
end
