# frozen_string_literal: true

class GroupsController < ApplicationController
  include GroupsHelper
  before_action :set_group, only: %i[show edit update destroy journal]
  before_action :set_department_curators, only: %i[create edit new]

  def show
    authorize @group

    @grouped_lectures = @group.lectures.includes(:lecture_time).order('weekday').order('lecture_times.beginning').group_by(&:weekday)
    @students = @group.students
    @curator = @group.curator
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
        format.html { redirect_to group_url(@group), notice: 'Group was successfully created.' }
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
        format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to groups_url, notice: 'Something went wrong.' }
      end
    end
  end

  def index
    @groups = Group.includes(:department, :curator).order(:department_id).all

    @departments = Department.where(params[:department_id])&.first || Department.first
    if params[:course] != '0' && !params[:course].nil?
      @groups = @groups.where(course: params[:course])
      end
    if params[:department_id]
      @groups = @groups.where(department_id: params[:department_id])
    end

    authorize Group
  end

  private

  def set_group
    @group = Group.find(params[:group_id] || params[:id])
  end

  def set_department_curators
    @departments = Department.select(:id, :name)
    @curators = Lecturer.free_curators(@group).select(:id, :name)
  end

  def group_params
    params.require(:group).permit(:department_id, :curator_id, :specialization_code, :course, :form_of_education,
                                  :subject)
  end
end
