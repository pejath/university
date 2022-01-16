class CreateJoinTableGroupLecture < ActiveRecord::Migration[6.1]
  def change
    create_join_table :groups, :lectures do |t|
      t.index [:group_id, :lecture_id]
      # t.index [:lecture_id, :group_id]
    end
  end
end
