FactoryBot.define do

  factory :mark do
    association :student, factory: :student
    association :subject, factory: :subject
    association :lecturer, factory: :lecturer

    # student_id { student.id }
    # subject_id { subject.id }
    # lecturer_id { lecturer.id }
    mark { rand(1..5) }
  end

end

