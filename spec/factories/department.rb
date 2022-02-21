FactoryBot.define do

  factory :department do
    association :faculty, factory: :faculty, name: 'Test'

    faculty_id { faculty.id }
    name { 'Test' }
    formation_date { '20.12.2002' }
    department_type { 'Basic' }
  end

end

