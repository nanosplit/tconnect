# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180404164240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classroom_students", force: :cascade do |t|
    t.bigint "district_id"
    t.bigint "school_id"
    t.bigint "student_id"
    t.bigint "classroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_classroom_students_on_classroom_id"
    t.index ["district_id"], name: "index_classroom_students_on_district_id"
    t.index ["school_id"], name: "index_classroom_students_on_school_id"
    t.index ["student_id"], name: "index_classroom_students_on_student_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "district_schools", force: :cascade do |t|
    t.bigint "school_id"
    t.bigint "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_district_schools_on_district_id"
    t.index ["school_id"], name: "index_district_schools_on_school_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guardians", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_invoices", force: :cascade do |t|
    t.bigint "message_id"
    t.integer "amount"
    t.bigint "message_invoiceable_id"
    t.string "message_invoiceable_type"
    t.bigint "payer_id"
    t.string "payer_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_message_invoices_on_message_id"
  end

  create_table "message_recipients", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "message_receivable_id"
    t.bigint "message_receivable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_message_recipients_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.text "media_url"
    t.bigint "classroom_id"
    t.bigint "message_sendable_id"
    t.string "message_sendable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_classrooms", force: :cascade do |t|
    t.bigint "district_id"
    t.bigint "school_id"
    t.bigint "classroom_id"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_school_classrooms_on_classroom_id"
    t.index ["district_id"], name: "index_school_classrooms_on_district_id"
    t.index ["school_id"], name: "index_school_classrooms_on_school_id"
    t.index ["teacher_id"], name: "index_school_classrooms_on_teacher_id"
  end

  create_table "school_students", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "school_id"
    t.bigint "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_school_students_on_district_id"
    t.index ["school_id"], name: "index_school_students_on_school_id"
    t.index ["student_id"], name: "index_school_students_on_student_id"
  end

  create_table "school_teachers", force: :cascade do |t|
    t.bigint "district_id"
    t.bigint "school_id"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_school_teachers_on_district_id"
    t.index ["school_id"], name: "index_school_teachers_on_school_id"
    t.index ["teacher_id"], name: "index_school_teachers_on_teacher_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_guardians", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "guardian_id"
    t.bigint "school_id"
    t.bigint "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_student_guardians_on_district_id"
    t.index ["guardian_id"], name: "index_student_guardians_on_guardian_id"
    t.index ["school_id"], name: "index_student_guardians_on_school_id"
    t.index ["student_id"], name: "index_student_guardians_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_students", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_teacher_students_on_student_id"
    t.index ["teacher_id"], name: "index_teacher_students_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "classroom_students", "classrooms"
  add_foreign_key "classroom_students", "districts"
  add_foreign_key "classroom_students", "schools"
  add_foreign_key "classroom_students", "students"
  add_foreign_key "district_schools", "districts"
  add_foreign_key "district_schools", "schools"
  add_foreign_key "message_invoices", "messages"
  add_foreign_key "message_recipients", "messages"
  add_foreign_key "school_classrooms", "classrooms"
  add_foreign_key "school_classrooms", "districts"
  add_foreign_key "school_classrooms", "schools"
  add_foreign_key "school_classrooms", "teachers"
  add_foreign_key "school_students", "districts"
  add_foreign_key "school_students", "schools"
  add_foreign_key "school_students", "students"
  add_foreign_key "school_teachers", "districts"
  add_foreign_key "school_teachers", "schools"
  add_foreign_key "school_teachers", "teachers"
  add_foreign_key "student_guardians", "districts"
  add_foreign_key "student_guardians", "guardians"
  add_foreign_key "student_guardians", "schools"
  add_foreign_key "student_guardians", "students"
  add_foreign_key "teacher_students", "students"
  add_foreign_key "teacher_students", "teachers"
end
