class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.belongs_to :faculty
      t.belongs_to :lecturer
      t.integer :specialization_code
      t.integer :course
      t.string :form_of_education

      t.timestamps
    end
  end
end
