FactoryBot.define do

  factory :lecturer do
    trait :curator do
      after(:create) do |lecturer|
        FactoryBot.create(:group, curator: lecturer)
      end
    end

    association :department, factory: :department

    department_id { department.id }
    name { Faker::Name.name }
    academic_degree {}
  end

  factory :invalid_lecturer, class: Lecturer do
    name { nil }
  end
end

