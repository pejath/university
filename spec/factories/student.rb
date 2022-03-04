FactoryBot.define do

  factory :student do
    trait :random_student do
      association :group, factory: :group
    end

    trait :with_red_diploma do
      association :group, factory: :group, course: 5
      after(:create) do |student|
        FactoryBot.create(:mark, mark: 5, student: student)
      end
    end
    group_id { group.id}
    name { Faker::Name.name }
  end

  factory :invalid_student, class: Student do
    name { nil }
  end
end

