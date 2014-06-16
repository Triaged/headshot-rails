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

ActiveRecord::Schema.define(version: 20140616174751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
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

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "uses_departments", default: true
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.boolean  "shared"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "users_count", default: 0
  end

  create_table "employee_infos", force: true do |t|
    t.string   "job_title"
    t.string   "cell_phone"
    t.string   "office_phone"
    t.date     "job_start_date"
    t.date     "birth_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "current_availability"
    t.integer  "home_office_location_id"
    t.integer  "current_office_location_id"
  end

  add_index "employee_infos", ["current_office_location_id"], name: "index_employee_infos_on_current_office_location_id", using: :btree
  add_index "employee_infos", ["home_office_location_id"], name: "index_employee_infos_on_home_office_location_id", using: :btree
  add_index "employee_infos", ["user_id"], name: "index_employee_infos_on_user_id", using: :btree

  create_table "imported_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "import"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
  end

  create_table "office_locations", force: true do |t|
    t.string   "name"
    t.string   "street_address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
  end

  add_index "office_locations", ["company_id"], name: "index_office_locations_on_company_id", using: :btree

  create_table "provider_credentials", force: true do |t|
    t.integer  "user_id"
    t.integer  "provider_id"
    t.integer  "company_id"
    t.string   "uid"
    t.string   "access_token"
    t.string   "token_secret"
    t.string   "refresh_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_credentials", ["company_id"], name: "index_provider_credentials_on_company_id", using: :btree
  add_index "provider_credentials", ["provider_id"], name: "index_provider_credentials_on_provider_id", using: :btree
  add_index "provider_credentials", ["user_id"], name: "index_provider_credentials_on_user_id", using: :btree

  create_table "providers", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "short_title"
    t.boolean  "active"
    t.boolean  "oauth"
    t.string   "oauth_path"
    t.string   "large_icon"
    t.string   "small_icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["company_id"], name: "index_teams_on_company_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
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
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "company_id"
    t.string   "title"
    t.integer  "team_id"
    t.string   "phone_number"
    t.string   "avatar"
    t.integer  "manager_id"
    t.date     "start_date"
    t.date     "birthday"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token"
    t.integer  "department_id"
    t.boolean  "admin"
    t.boolean  "installed_app"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["department_id"], name: "index_users_on_department_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["manager_id"], name: "index_users_on_manager_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree

end
