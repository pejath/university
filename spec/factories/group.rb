FactoryBot.define do

  factory :group do
    association :curator, factory: :lecturer
    association :department, factory: :department

    department_id { department.id }
    curator_id { curator.id }
    specialization_code { 1 }
    course { rand(1..5) }
    form_of_education { 'evening' }
  end

end

