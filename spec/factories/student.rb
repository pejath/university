FactoryBot.define do

  factory :student do
    trait :random_student do
      association :group, factory: :group
    end

    trait :with_red_diploma do
      association :group, factory: :group, course: 5
    end
    name { Faker::Name.name }
  end
end

