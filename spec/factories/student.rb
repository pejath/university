FactoryBot.define do

  factory :student do
    association :group, factory: :group

    group_id { group.id }
    name { Faker::Name.name }
  end

end

