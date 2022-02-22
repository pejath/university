FactoryBot.define do

  factory :student do
    trait :random_student do
      association :group, factory: :group
      group_id { group.id }
      name { Faker::Name.name }
    end


    trait :fifth_course_student do
      association :group, factory: :group, course: 5
      group_id { group.id }
      name { Faker::Name.name }
    end
  end
end

