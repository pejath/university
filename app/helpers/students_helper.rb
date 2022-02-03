
module StudentsHelper
  def filter_by_params(scope, params)

    if params.key?(:group_id)
      if params[:group_id] == ''
        scope.all
        else
      scope.where(group_id: params[:group_id])
        end
    else
      scope.all
    end


  end

  def red_diplomas(scope, params)
    if params.key?(:group_id)
      scope.red_diplomas.where(group_id: params[:group_id])
    else
      scope.red_diplomas
    end
  end

end
