class CreateMethodists < ActiveRecord::Migration[6.1]
  def change
    create_table :methodists do |t|
      t.string :name

      t.timestamps
    end
  end
end
