# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_17_114136) do

  create_table "departments", force: :cascade do |t|
    t.integer "faculty_id"
    t.string "name"
    t.string "department_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "formation_dates", force: :cascade do |t|
    t.date "formation_date"
    t.string "formed_type", null: false
    t.integer "formed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["formed_type", "formed_id"], name: "index_formation_dates_on_formed"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "faculty_id"
    t.integer "specialization_code"
    t.integer "course"
    t.string "form_of_education"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_groups_on_faculty_id"
  end

  create_table "lecture_times", force: :cascade do |t|
    t.time "beginning"
  end

  create_table "lecturers", force: :cascade do |t|
    t.integer "department_id"
    t.string "name"
    t.integer "academic_degree"
    t.string "post"
    t.integer "curatorial_group"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_lecturers_on_department_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.integer "lecture_time_id"
    t.integer "group_id"
    t.integer "lecturer_id"
    t.integer "corpus"
    t.integer "auditorium"
    t.index ["group_id"], name: "index_lectures_on_group_id"
    t.index ["lecture_time_id"], name: "index_lectures_on_lecture_time_id"
    t.index ["lecturer_id"], name: "index_lectures_on_lecturer_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "group_id"
    t.string "name"
    t.float "average_mark"
    t.index ["group_id"], name: "index_students_on_group_id"
  end

end
