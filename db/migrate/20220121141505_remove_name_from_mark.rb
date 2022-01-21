class RemoveNameFromMark < ActiveRecord::Migration[6.1]
  def change
    remove_column :marks, :name, :string
  end
end
