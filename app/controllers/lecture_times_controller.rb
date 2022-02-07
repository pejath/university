class LectureTimesController < ApplicationController
  before_action :set_lecture_time, only: %i[ show edit update destroy ]

  # GET /lecture_times or /lecture_times.json
  def index
    @lecture_times = LectureTime.all
  end

  # GET /lecture_times/1 or /lecture_times/1.json
  def show
  end

  # GET /lecture_times/new
  def new
    @lecture_time = LectureTime.new
  end

  # GET /lecture_times/1/edit
  def edit
  end

  # POST /lecture_times or /lecture_times.json
  def create
    @lecture_time = LectureTime.new(lecture_time_params)

    respond_to do |format|
      if @lecture_time.save
        format.html { redirect_to lecture_times_url(@lecture_time), notice: "Lecture time was successfully created." }
        format.json { render :show, status: :created, location: @lecture_time }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lecture_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lecture_times/1 or /lecture_times/1.json
  def update
    respond_to do |format|
      if @lecture_time.update(lecture_time_params)
        format.html { redirect_to lecture_times_url(@lecture_time), notice: "Lecture time was successfully updated." }
        format.json { render :show, status: :ok, location: @lecture_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lecture_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lecture_times/1 or /lecture_times/1.json
  def destroy
    @lecture_time.destroy

    respond_to do |format|
      if @lecture_time.destroy
      format.html { redirect_to lecture_times_url, notice: "Lecture time was successfully destroyed." }
      format.json { head :no_content }
      else
        format.html { redirect_to group_url, notice: "Something went wrong."}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture_time
      @lecture_time = LectureTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lecture_time_params
      params.require(:lecture_time).permit(:beginning)
    end
end
