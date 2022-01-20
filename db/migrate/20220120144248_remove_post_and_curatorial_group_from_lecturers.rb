class RemovePostAndCuratorialGroupFromLecturers < ActiveRecord::Migration[6.1]
  def change
    remove_column :lecturers, :post, :string
    remove_column :lecturers, :curatorial_group, :integer
  end
end
