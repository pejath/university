# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_name_generator'
@rnd = RandomNameGenerator.new
@facults = %w[Биологический Военный Журналистики Исторический]

Faculty.create(name: 'Биологический')
Faculty.create(name: 'Географии')
Faculty.create(name: 'Исторический')
Faculty.create(name: 'Журналистики')
Faculty.create(name: 'Экономический')

Department.create(name: 'Ботаники', faculty_id: 1, department_type: 'Interfacult')
Department.create(name: 'Генетики', faculty_id: 1, department_type: 'Basic')
Department.create(name: 'Географической экологии', faculty_id: 2, department_type: 'Basic')
Department.create(name: 'Экономической и социальной географии', faculty_id: 2, department_type: 'Interfacult')
Department.create(name: 'Истории России', faculty_id: 3, department_type: 'Interfacult')
Department.create(name: 'Древнего мира', faculty_id: 3, department_type: 'Basic')
Department.create(name: 'Медиалогии', faculty_id: 4, department_type: 'Basic')
Department.create(name: 'Телевидения и радиовещания', faculty_id: 4, department_type: 'Basic')
Department.create(name: 'Банковской экономики', faculty_id: 5, department_type: 'Interfacult')
Department.create(name: 'Цифровой Экономики', faculty_id: 5, department_type: 'Basic')
Department.create(name: 'Геодезии', faculty_id: 2, department_type: 'Interfacult')
Department.create(name: 'Источниковедения', faculty_id: 3, department_type: 'Interfacult')

Group.create(faculty_id: 1, specialization_code: rand(400), course: 1, form_of_education: 'evening')
Group.create(faculty_id: 1, specialization_code: rand(400), course: 2, form_of_education: 'evening')
Group.create(faculty_id: 3, specialization_code: rand(400), course: 3, form_of_education: 'evening')
Group.create(faculty_id: 5, specialization_code: rand(400), course: 4, form_of_education: 'evening')
Group.create(faculty_id: 4, specialization_code: rand(400), course: 5, form_of_education: 'correspondence')
Group.create(faculty_id: 2, specialization_code: rand(400), course: 1, form_of_education: 'correspondence')
Group.create(faculty_id: 2, specialization_code: rand(400), course: 2, form_of_education: 'correspondence')
Group.create(faculty_id: 3, specialization_code: rand(400), course: 3, form_of_education: 'correspondence')
Group.create(faculty_id: 5, specialization_code: rand(400), course: 4, form_of_education: 'full-time')
Group.create(faculty_id: 1, specialization_code: rand(400), course: 5, form_of_education: 'full-time')
Group.create(faculty_id: 2, specialization_code: rand(400), course: 1, form_of_education: 'full-time')
Group.create(faculty_id: 4, specialization_code: rand(400), course: 2, form_of_education: 'full-time')
Group.create(faculty_id: 4, specialization_code: rand(400), course: 3, form_of_education: 'full-time')
Group.create(faculty_id: 2, specialization_code: rand(400), course: 4, form_of_education: 'full-time')
Group.create(faculty_id: 1, specialization_code: rand(400), course: 5, form_of_education: 'full-time')

15.times do
||
  Lecturer.create(name: @rnd.compose(3), academic_degree: rand(1..5), post: "lecturer")
end

20.times{
  ||
  Student.create(group_id: 1, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 2, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 3, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 4, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 5, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 6, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 7, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 8, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 9, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 10, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 11, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 12, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 13, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 14, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 15, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
  Student.create(group_id: 16, name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
}

20.times do
||
  Student.create(group_id: rand(1..16), name: @rnd.compose, average_mark: rand(2.0..5.0).round(2))
end
(1..15).each do |i|
  Lecturer.create(name: @rnd.compose, academic_degree: rand(1..5), post: 'куратор', curatorial_group: i)
end

LectureTime.create(beginning: '9:00')
LectureTime.create(beginning: '10:35')
LectureTime.create(beginning: '12:25')
LectureTime.create(beginning: '14:00')
LectureTime.create(beginning: '15:50')
LectureTime.create(beginning: '17:10')
LectureTime.create(beginning: '19:00')
LectureTime.create(beginning: '20:40')

100.times {
  Lecture.create(auditorium: rand(900), corpus: rand(1..4), lecture_time_id: rand(1..8), group_id: rand(1..15), lecturer: rand(1..15))
}