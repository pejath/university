class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :edit_new_params, only: %i[edit new]
  def show; end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)

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
    @group.destroy

    respond_to do |format|
      format.html { redirect_to group_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def index
    @groups = Group.includes(:faculty, :curator).all
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def edit_new_params
    @faculties = Faculty.select(:name)
    @curators = Lecturer.free_curators.select(:name)
  end

  def group_params
    params.require(:group).permit(:faculty_id, :curator_id, :specialization_code, :course, :form_of_education)
  end
end