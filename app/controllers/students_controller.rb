class StudentsController < ApplicationController
  def red_diplomas
    @students = Student.red_diplomas
    @marks = Mark.all
  end

  def journal
    params.permit(:group)
    @students = if params.key?(:group)
                  Student.where(group_id: params[:group])
                else
                  Student.all
                end
    @groups_id = Group.select(:id)
    @marks = Mark.all
  end
end
