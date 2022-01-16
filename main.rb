Faculty.new(name:"Test Faculty").save
Department.new(name: "Test department", faculty_id: 1, department_type: "Interfacult").save
Group.new(faculty_id: 1, specialization_code:123, course: 1, form_of_education: "full-time").save
