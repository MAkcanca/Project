# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150328232003) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",       default: "", null: false
    t.string   "description", default: "", null: false
    t.integer  "course_id",   default: 0,  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title",                                             null: false
    t.string   "description",  default: "No description available", null: false
    t.string   "author",                                            null: false
    t.string   "isbn",                                              null: false
    t.integer  "pages",                                             null: false
    t.string   "publisher",                                         null: false
    t.date     "publish_date",                                      null: false
    t.integer  "category_id",                                       null: false
    t.date     "due_date"
    t.integer  "user_id"
    t.integer  "holder_id"
    t.boolean  "renewed",      default: false,                      null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "books_categories", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "category_id"
  end

  add_index "books_categories", ["book_id", "category_id"], name: "index_books_categories_on_book_id_and_category_id"

  create_table "books_users", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "user_id"
  end

  add_index "books_users", ["book_id", "user_id"], name: "index_books_users_on_book_id_and_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title",                         null: false
    t.string   "description",                   null: false
    t.integer  "enrolled",      default: 0,     null: false
    t.integer  "capacity",      default: 0,     null: false
    t.integer  "user_id"
    t.integer  "instructor_id", default: 0,     null: false
    t.integer  "semester_id",   default: 0,     null: false
    t.integer  "department_id", default: 0,     null: false
    t.string   "course_number",                 null: false
    t.boolean  "m",             default: false, null: false
    t.boolean  "t",             default: false, null: false
    t.boolean  "w",             default: false, null: false
    t.boolean  "r",             default: false, null: false
    t.boolean  "f",             default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "user_id"
  end

  add_index "courses_users", ["course_id", "user_id"], name: "index_courses_users_on_course_id_and_user_id"

  create_table "departments", force: :cascade do |t|
    t.string   "title",        default: "", null: false
    t.string   "abbreviation", default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "folders", force: :cascade do |t|
    t.string   "title",           default: "",    null: false
    t.string   "description",     default: "",    null: false
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "upload_id"
    t.boolean  "instructor_only", default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "grades", force: :cascade do |t|
    t.string   "title",                  null: false
    t.integer  "score",      default: 0
    t.integer  "max_score",  default: 0
    t.integer  "user_id",    default: 0, null: false
    t.integer  "course_id",  default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "homes", force: :cascade do |t|
    t.string   "title",       default: "", null: false
    t.string   "description", default: "", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "semesters", force: :cascade do |t|
    t.string   "title",      default: "",           null: false
    t.date     "start_date", default: '1900-01-01', null: false
    t.date     "end_date",   default: '1900-01-01', null: false
    t.integer  "course_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "title",      default: "", null: false
    t.string   "attachment", default: "", null: false
    t.integer  "user_id",    default: 0,  null: false
    t.integer  "course_id",  default: 0,  null: false
    t.integer  "folder_id",  default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "avatar"
    t.integer  "role",                   default: 0,  null: false
    t.integer  "department_id",          default: 0,  null: false
    t.integer  "grade_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
