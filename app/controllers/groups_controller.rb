class GroupsController < ApplicationController
  include GroupsHelper
  before_action :set_group, only: %i[show edit update destroy journal]
  before_action :set_department_curators, only: %i[create edit new]

  def show
    authorize @group

    if current_user.is_admin? || current_user.is_lecturer?
      @students = @group.students
      @marks = Mark.where(student_id: @students)
    elsif current_user.is_student?
      if @group.id == current_user.owner.group_id
        @students = @group.students
        @marks = Mark.where(student_id: @students)
      else
        @students = nil
      end
    else
      @students = nil
    end
  end

  def new
    @group = Group.new
    authorize @group
  end

  def journal
    authorize @group
    @students = @group.students
    @subject = Subject.where(id: params[:subject])
    @marks = Mark.where(student_id: @students)
    @marks = subject_marks(@marks, @subject)
  end

  def edit
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    authorize @group

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @group
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @group
    respond_to do |format|
      if @group.destroy
        format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to groups_url, notice: "Something went wrong." }
      end
    end
  end

  def index
    @groups = Group.includes(:department, :curator).order(:department_id).all
    authorize Group
  end

  private

  def set_group
    if params[:group_id]
      @group = Group.find(params[:group_id])
    else
      @group = Group.find(params[:id])
    end
  end

  def set_department_curators
    @departments = Department.select(:id, :name)
    @curators = Lecturer.free_curators(@group).select(:id, :name)
  end

  def group_params
    params.require(:group).permit(:department_id, :curator_id, :specialization_code, :course, :form_of_education, :subject)
  end
end
