class CreateLecturers < ActiveRecord::Migration[6.1]
  def change
    create_table :lecturers do |t|
      t.belongs_to :department
      t.string :name
      t.integer :academic_degree
      t.string :post
      t.integer :curatorial_group

      t.timestamps
    end
  end
end
