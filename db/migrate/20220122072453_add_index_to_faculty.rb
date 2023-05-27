# frozen_string_literal: true

class AddIndexToFaculty < ActiveRecord::Migration[6.1]
  def change
    add_index :faculties, :name, unique: true
  end
end
