# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_name_generator'
RND = RandomNameGenerator.new
FACULTS = %w[Биологический Географии Исторический Журналистики Экономический]
FORM_OF_EDUCATION = %w[evening correspondence full_time]
DEPARTMENT = %w['Ботаники','Генетики']
DATE = '1999.12.12'

FACULTS.each{|facult|
  Faculty.create(name: facult, formation_date: "19#{rand(70..99)}.#{month = rand(1..12)}.#{month != 2? rand(1..28):rand(1..30)}")
}

Department.create(name: 'Ботаники', faculty_id: 1, department_type: 'Interfacult', formation_date: DATE)
Department.create(name: 'Генетики', faculty_id: 1, department_type: 'Basic', formation_date: DATE)
Department.create(name: 'Географической экологии', faculty_id: 2, department_type: 'Basic', formation_date: DATE)
Department.create(name: 'Экономической и социальной географии', faculty_id: 2, department_type: 'Interfacult', formation_date: DATE)
Department.create(name: 'Истории России', faculty_id: 3, department_type: 'Interfacult', formation_date: DATE)
Department.create(name: 'Древнего мира', faculty_id: 3, department_type: 'Basic', formation_date: DATE)
Department.create(name: 'Медиалогии', faculty_id: 4, department_type: 'Basic', formation_date: DATE)
Department.create(name: 'Телевидения и радиовещания', faculty_id: 4, department_type: 'Basic', formation_date: DATE)
Department.create(name: 'Банковской экономики', faculty_id: 5, department_type: 'Interfacult', formation_date: DATE)
Department.create(name: 'Цифровой Экономики', faculty_id: 5, department_type: 'Basic', formation_date: DATE)
Department.create(name: 'Геодезии', faculty_id: 2, department_type: 'Interfacult', formation_date: DATE)
Department.create(name: 'Источниковедения', faculty_id: 3, department_type: 'Interfacult', formation_date: DATE)




(1..15).each do |i|
  Lecturer.create(department_id: 1, name: RND.compose, academic_degree: rand(1..5))
end

16.times{
  Group.create(faculty_id: rand(1..Faculty.count), specialization_code: rand(400), course: rand(1..5), form_of_education: FORM_OF_EDUCATION.sample, lecturer_id: rand(1..15))
}

16.times{|i|
  20.times{
    Student.create(group_id: i, name: RND.compose)
  }
}

20.times do
  Student.create(group_id: rand(1..16), name: RND.compose)
end

20.times do
  Student.create(group_id: 1, name: RND.compose)
end

(1..15).each {
  |i|
  Subject.create(name: "Math", code: i, lecturer_id: i)
}

LectureTime.create(beginning: '9:00')
LectureTime.create(beginning: '10:35')
LectureTime.create(beginning: '12:25')
LectureTime.create(beginning: '14:00')
LectureTime.create(beginning: '15:50')
LectureTime.create(beginning: '17:10')
LectureTime.create(beginning: '19:00')
LectureTime.create(beginning: '20:40')

100.times {
  Lecture.create(auditorium: rand(900), corpus: rand(1..4), lecture_time_id: rand(1..8), group_id: rand(1..15), lecturer_id: rand(1..15))
}

(1..20).each {
  |i|
  5.times {
    Mark.create(lecturer_id: rand(1..15), mark: rand(1..5), student_id:i)
  }
}