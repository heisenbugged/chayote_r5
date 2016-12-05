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

ActiveRecord::Schema.define(version: 20161205141548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "members", force: :cascade do |t|
    t.string  "mongo_id",   default: "", null: false
    t.integer "project_id"
    t.integer "user_id"
    t.index ["project_id"], name: "index_members_on_project_id", using: :btree
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string "name",     default: "", null: false
    t.string "mongo_id", default: "", null: false
    t.index ["name"], name: "index_projects_on_name", unique: true, using: :btree
  end

  create_table "rates", force: :cascade do |t|
    t.decimal "amount",     default: "0.0", null: false
    t.string  "mongo_id",   default: "",    null: false
    t.integer "project_id"
    t.integer "user_id"
    t.index ["project_id"], name: "index_rates_on_project_id", using: :btree
    t.index ["user_id"], name: "index_rates_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "mongo_id",   default: "", null: false
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["project_id"], name: "index_tasks_on_project_id", using: :btree
    t.index ["user_id"], name: "index_tasks_on_user_id", using: :btree
  end

  create_table "time_entries", force: :cascade do |t|
    t.decimal  "hours",      default: "0.0", null: false
    t.date     "date"
    t.string   "mongo_id",   default: "",    null: false
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["task_id"], name: "index_time_entries_on_task_id", using: :btree
    t.index ["user_id"], name: "index_time_entries_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name",              default: "",    null: false
    t.decimal  "base_rate",              default: "0.0", null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "mongo_id",               default: "",    null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "members", "projects"
  add_foreign_key "members", "users"
  add_foreign_key "rates", "projects"
  add_foreign_key "rates", "users"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users"
  add_foreign_key "time_entries", "tasks"
  add_foreign_key "time_entries", "users"
end
