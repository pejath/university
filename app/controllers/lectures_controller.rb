class LecturesController < ApplicationController
  before_action :get_group
  before_action :set_lecturers_subject_and_time, only: %i[create edit new]
  before_action :set_lecture, only: %i[ show edit update destroy ]

  # GET /groups/:id/lectures or /groups/:id/lectures.json
  def index
    @lectures = @group.lectures.order(:weekday).order(:lecture_time_id)
  end

  # GET /groups/:id/lectures/1 or /groups/:id/lectures/1.json
  def show; end

  # GET /groups/:id/lectures/new
  def new
    @lecture = @group.lectures.build
  end

  # GET /groups/:id/lectures/1/edit
  def edit; end

  # POST /groups/:id/lectures or /groups/:id/lectures.json
  def create
    @lecture = @group.lectures.build(lecture_params)

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to group_lecture_path(@group, @lecture), notice: "Lecture was successfully created." }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/:id/lectures/1 or /groups/:id/lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to group_lecture_path, notice: "Lecture was successfully updated." }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/:id/lectures/1 or /groups/:id/lectures/1.json
  def destroy

    respond_to do |format|
      if @lecture.destroy
        format.html { redirect_to group_lectures_path, notice: "Lecture was successfully destroyed." }
      else
        format.html { redirect_to group_lectures_path, notice: "Something went wrong."}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

  def set_lecturers_subject_and_time

    @lectures_time = LectureTime.all
    @subjects = Subject.all
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
    params.require(:lecture).permit(:lecture_time_id, :group_id, :lecturer_id, :subject_id, :weekday, :corpus, :auditorium)
  end
end
