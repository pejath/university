class DepartmentsController < ApplicationController
  before_action :set_faculty
  before_action :set_department, only: %i[ show edit update destroy ]

  # GET /faculties/:id/departments or /faculties/:id/departments.json
  def index
    @departments = @faculty.departments
  end

  # GET /faculties/:id/departments/1 or /faculties/:id/departments/1.json
  def show; end

  # GET /faculties/:id/departments/new
  def new
    @department = @faculty.departments.build
  end

  # GET /faculties/:id/departments/1/edit
  def edit; end

  # POST /faculties/:id/departments or /faculties/:id/departments.json
  def create
    @department = @faculty.departments.build(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to faculty_department_url(@department), notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faculties/:id/departments/1 or /faculties/:id/departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to faculty_department_url(@department), notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faculties/:id/departments/1 or /faculties/:id/departments/1.json
  def destroy
    respond_to do |format|
      if @department.destroy
        format.html { redirect_to faculty_departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
      else
        format.html { redirect_to faculty_departments_url, notice: 'Something go wrong.' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_department
    @department = @faculty.departments.find(params[:department_id])
  end

  def set_faculty
    @faculty = Faculty.find(params[:faculty_id])
  end

  # Only allow a list of trusted parameters through.
  def department_params
    params.require(:department).permit(:name, :faculty_id, :department_type)
  end
end
