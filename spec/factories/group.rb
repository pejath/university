FactoryBot.define do

  factory :group do
    association :curator, factory: :lecturer
    association :department, factory: :department

    department_id { department.id }
    curator_id { curator.id }
    specialization_code { rand(1..10000) }
    course { rand(1..5) }
    form_of_education { 'evening' }
  end

  factory :invalid_group, class: Group do
    course { nil }
  end
end

