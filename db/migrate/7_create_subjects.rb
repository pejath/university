class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :name, null: false

      t.timestamps
    end
    create_table :lecturers_subjects, id: false do |t|
      t.belongs_to :subject
      t.belongs_to :lecturer

    end

  end
end
