class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.belongs_to :faculty
      t.belongs_to :lecturer
      t.integer :specialization_code, null: false
      t.integer :course, null: false
      t.integer :form_of_education

      t.timestamps
    end
  end
end
