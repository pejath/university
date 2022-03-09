FactoryBot.define do

  factory :subject do
    name { Faker::FunnyName.name }
  end

  factory :invalid_subject, class: Subject do
    name { nil }
  end
end

