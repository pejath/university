
module StudentsHelper
  def filter_by_params(scope, params)

    params.each do |key, value|
      next if value.empty?

      scope = case key.to_s
              when 'group_id'
                scope.where(group_id: value)
              when 'red_diplomas'
                scope.red_diplomas
              else
                scope.all
              end
    end
    scope.order(:group_id)
  end
end
