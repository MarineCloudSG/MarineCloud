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

ActiveRecord::Schema.define(version: 202204020181742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "parameters", force: :cascade do |t|
    t.string "label"
    t.string "code"
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "systems", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
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

  create_table "vessel_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vessel_system_parameters", force: :cascade do |t|
    t.bigint "vessel_system_id", null: false
    t.bigint "parameter_id", null: false
    t.bigint "vessel_id", null: false
    t.float "min_satisfactory"
    t.float "max_satisfactory"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parameter_id"], name: "index_vessel_system_parameters_on_parameter_id"
    t.index ["vessel_id"], name: "index_vessel_system_parameters_on_vessel_id"
    t.index ["vessel_system_id"], name: "index_vessel_system_parameters_on_vessel_system_id"
  end

  create_table "vessel_systems", force: :cascade do |t|
    t.bigint "vessel_id", null: false
    t.bigint "system_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["system_id"], name: "index_vessel_systems_on_system_id"
    t.index ["vessel_id"], name: "index_vessel_systems_on_vessel_id"
  end

  create_table "vessels", force: :cascade do |t|
    t.string "name"
    t.string "company_name"
    t.datetime "last_data_upload", precision: 6
    t.string "email"
    t.integer "chemical_program"
    t.bigint "vessel_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vessel_group_id"], name: "index_vessels_on_vessel_group_id"
  end

  add_foreign_key "vessel_system_parameters", "parameters"
  add_foreign_key "vessel_system_parameters", "vessel_systems"
  add_foreign_key "vessel_system_parameters", "vessels"
  add_foreign_key "vessel_systems", "systems"
  add_foreign_key "vessel_systems", "vessels"
  add_foreign_key "vessels", "vessel_groups"
end
