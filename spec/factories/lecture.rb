FactoryBot.define do

  factory :lecture do
    association :lecture_time, factory: :lecture_time
    association :group, factory: :group
    association :lecturer, factory: :lecturer
    association :subject, factory: :subject

    lecture_time_id { lecture_time.id }
    group_id { group.id }
    lecturer_id { lecturer.id }
    subject_id { subject.id }
    weekday { 'Monday' }
    corpus { 1 }
    auditorium { 1 }
  end

end

