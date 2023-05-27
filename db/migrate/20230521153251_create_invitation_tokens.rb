# frozen_string_literal: true

class CreateInvitationTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :invitation_tokens do |t|
      t.belongs_to :lecturer, null: true
      t.belongs_to :student, null: true
      t.belongs_to :admin, null: true
      t.belongs_to :methodist, null: true

      t.string :token, unique: true
      t.timestamps
    end
  end
end
