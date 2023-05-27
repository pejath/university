# frozen_string_literal: true

module GroupsHelper
  def subject_marks(marks, subject)
    return unless subject

    marks.where(subject_id: subject)
  end
end
