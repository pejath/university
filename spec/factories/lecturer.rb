FactoryBot.define do

  factory :lecturer do
    association :department, factory: :department

    department_id { department.id }
    name { Faker::Name.name }
    academic_degree {}
  end

end

