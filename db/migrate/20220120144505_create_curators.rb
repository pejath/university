class CreateCurators < ActiveRecord::Migration[6.1]
  def change
    create_table :curators do |t|
      t.belongs_to :lecturer
      t.belongs_to :group
      t.timestamps
    end
  end
end
