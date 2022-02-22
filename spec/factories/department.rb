FactoryBot.define do

  factory :department do
    association :faculty, factory: :faculty

    faculty_id { faculty.id }
    name { Faker::Company.name }
    formation_date { '20.12.2002' }
    department_type { 'Basic' }
  end

end

