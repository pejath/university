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

ActiveRecord::Schema.define(version: 2023_05_21_170510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.bigint "faculty_id"
    t.string "name", null: false
    t.integer "department_type", null: false
    t.date "formation_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name", null: false
    t.date "formation_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_faculties_on_name", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "department_id"
    t.bigint "curator_id"
    t.integer "specialization_code", null: false
    t.integer "course", null: false
    t.integer "form_of_education", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["curator_id"], name: "index_groups_on_curator_id"
    t.index ["department_id"], name: "index_groups_on_department_id"
  end

  create_table "invitation_tokens", force: :cascade do |t|
    t.bigint "lecturer_id"
    t.bigint "student_id"
    t.bigint "admin_id"
    t.bigint "methodist_id"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_invitation_tokens_on_admin_id"
    t.index ["lecturer_id"], name: "index_invitation_tokens_on_lecturer_id"
    t.index ["methodist_id"], name: "index_invitation_tokens_on_methodist_id"
    t.index ["student_id"], name: "index_invitation_tokens_on_student_id"
  end

  create_table "lecture_times", force: :cascade do |t|
    t.time "beginning", null: false
  end

  create_table "lecturers", force: :cascade do |t|
    t.bigint "department_id"
    t.string "name", null: false
    t.integer "academic_degree"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_lecturers_on_department_id"
  end

  create_table "lecturers_subjects", force: :cascade do |t|
    t.bigint "lecturer_id"
    t.bigint "subject_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecturer_id", "subject_id"], name: "index_lecturers_subjects_on_lecturer_id_and_subject_id", unique: true
    t.index ["lecturer_id"], name: "index_lecturers_subjects_on_lecturer_id"
    t.index ["subject_id"], name: "index_lecturers_subjects_on_subject_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.bigint "lecture_time_id"
    t.bigint "group_id"
    t.bigint "lecturer_id"
    t.bigint "subject_id"
    t.integer "weekday", null: false
    t.integer "corpus", null: false
    t.integer "auditorium", null: false
    t.index ["corpus", "auditorium", "lecture_time_id", "group_id", "lecturer_id", "weekday"], name: "lecture_index", unique: true
    t.index ["group_id"], name: "index_lectures_on_group_id"
    t.index ["lecture_time_id"], name: "index_lectures_on_lecture_time_id"
    t.index ["lecturer_id"], name: "index_lectures_on_lecturer_id"
    t.index ["subject_id"], name: "index_lectures_on_subject_id"
  end

  create_table "marks", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "subject_id"
    t.bigint "lecturer_id"
    t.integer "mark", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecturer_id"], name: "index_marks_on_lecturer_id"
    t.index ["student_id"], name: "index_marks_on_student_id"
    t.index ["subject_id"], name: "index_marks_on_subject_id"
  end

  create_table "methodists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.bigint "group_id"
    t.string "name", null: false
    t.index ["group_id"], name: "index_students_on_group_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "token"
    t.integer "role"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "groups", "lecturers", column: "curator_id"
end
