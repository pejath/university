# frozen_string_literal: true

FactoryBot.define do
  factory :faculty do
    name { Faker::University.name }
    formation_date { '20.12.2002' }
  end

  factory :invalid_faculty, class: Faculty do
    name { nil }
  end
end
