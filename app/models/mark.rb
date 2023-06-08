# frozen_string_literal: true

class Mark < ApplicationRecord
  belongs_to :student
  belongs_to :subject
  belongs_to :lecturer, optional: true

  before_create :clear_created

  validates :mark, numericality: { only_integer: true, greater_than: 0, less_than: 6 }, presence: true

  def clear_created
    self.created_at = self.created_at.beginning_of_day
  end
end
