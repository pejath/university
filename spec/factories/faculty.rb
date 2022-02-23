FactoryBot.define do

  factory :faculty do
    name { Faker::University.name }
    formation_date { '20.12.2002' }
  end

end

