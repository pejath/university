class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.belongs_to :group
      t.string :name
      t.float :average_mark

    end
  end
end
