module GroupsHelper
  def subject_marks(marks, subject)

    if subject
      marks.where(subject_id: subject)
    else
      nil
    end
  end
end
