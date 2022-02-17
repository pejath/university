FactoryBot.define do

  factory :faculty do
    name { 'Test' }
    formation_date { '20.12.2002' }
  end

  factory :department do
    faculty
    faculty_id { faculty.id }
    name { 'Test' }
    formation_date { '20.12.2002' }
    department_type { 'Basic' }
  end

  factory :lecturer do
    department
    department_id { department.id }
    name { 'Jason' }
    academic_degree {}
  end

  factory :lecture_time do
    beginning { '00:00' }
  end

  factory :group do
    association :curator, factory: :lecturer, name: 'Jason'
    association :department, factory: :department, name: 'Test'


    department_id { department.id }
    curator_id { curator.id }
    specialization_code { 1 }
    course { 1 }
    form_of_education { 'evening' }
  end

  factory :student do
    group
    group_id { group.id }
    name { 'Mike' }
  end

  factory :subject do
    name { 'Math' }
  end

  factory :mark do
    student
    subject
    lecturer

    student_id { student.id }
    subject_id { subject.id }
    lecturer_id { lecturer.id }
    mark { 4 }
  end

  factory :lecture do
    lecture_time
    group
    lecturer
    subject

    lecture_time_id { lecture_time.id }
    group_id { group.id }
    lecturer_id { lecturer.id }
    subject_id { subject.id }
    weekday { 'Monday' }
    corpus { 1 }
    auditorium { 1 }
  end

  factory :lecturers_subject do
    lecturer
    subject

    lecturer_id { lecturer.id }
    subject_id { subject.id }
  end
end
