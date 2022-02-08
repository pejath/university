class MarksController < ApplicationController
  before_action :set_student
  before_action :set_mark, only: %i[ show edit update destroy ]

  # GET /students/:id/marks or /students/:id/marks.json
  def index
    @marks = @student.marks
  end

  # GET /students/:id/marks/1 or /students/:id/marks/1.json
  def show; end

  # GET /students/:id/marks/new
  def new
    @mark = @student.marks.build
  end

  # GET /students/:id/marks/1/edit
  def edit; end

  # POST /students/:id/marks or /students/:id/marks.json
  def create
    @mark = @student.marks.build(mark_params)

    respond_to do |format|
      if @mark.save
        format.html { redirect_to student_marks_path, notice: "Mark was successfully created." }
        format.json { render :show, status: :created, location: @mark }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/:id/marks/1 or /students/:id/marks/1.json
  def update
    respond_to do |format|
      if @mark.update(mark_params)
        format.html { redirect_to student_marks_path(@student), notice: "Mark was successfully updated." }
        format.json { render :show, status: :ok, location: @mark }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/:id/marks/1 or /students/:id/marks/1.json
  def destroy

    respond_to do |format|
      if @mark.destroy
        format.html { redirect_to student_marks_path(@student), notice: "Mark was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html{ redirect_to student_marks_path, notice: "Something went wrong"}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:student_id])
    @subject = Subject.select(:id, :name)
  end

  def set_mark
    @mark = @student.marks.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def mark_params
    params.require(:mark).permit(:subject_id, :mark, :student_id)
  end
end
