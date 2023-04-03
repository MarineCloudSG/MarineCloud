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

ActiveRecord::Schema.define(version: 202204020181784) do

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

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
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

  create_table "chemical_provider_parameters", force: :cascade do |t|
    t.bigint "chemical_provider_id", null: false
    t.bigint "system_id", null: false
    t.bigint "parameter_id", null: false
    t.float "min_satisfactory"
    t.float "max_satisfactory"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chemical_provider_id", "system_id", "parameter_id"], name: "index_chemical_provider_parameter_system", unique: true
    t.index ["chemical_provider_id"], name: "index_chemical_provider_parameters_on_chemical_provider_id"
    t.index ["parameter_id"], name: "index_chemical_provider_parameters_on_parameter_id"
    t.index ["system_id"], name: "index_chemical_provider_parameters_on_system_id"
  end

  create_table "chemical_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_chemical_providers_on_name", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "flag_file"
  end

  create_table "downloads", force: :cascade do |t|
    t.text "title"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "import_logs", force: :cascade do |t|
    t.bigint "measurements_import_id", null: false
    t.bigint "vessel_id", null: false
    t.text "msg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["measurements_import_id"], name: "index_import_logs_on_measurements_import_id"
    t.index ["vessel_id"], name: "index_import_logs_on_vessel_id"
  end

  create_table "measurements", force: :cascade do |t|
    t.datetime "taken_at", precision: 6
    t.float "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "vessel_system_parameter_id", null: false
    t.integer "state", default: 0
    t.bigint "measurements_import_id"
    t.index ["measurements_import_id"], name: "index_measurements_on_measurements_import_id"
    t.index ["vessel_system_parameter_id"], name: "index_measurements_on_vessel_system_parameter_id"
  end

  create_table "measurements_imports", force: :cascade do |t|
    t.bigint "vessel_id", null: false
    t.string "filename"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "source"
    t.string "tested_by"
    t.date "taken_at"
    t.index ["vessel_id"], name: "index_measurements_imports_on_vessel_id"
  end

  create_table "parameter_recommendations", force: :cascade do |t|
    t.decimal "value_min"
    t.decimal "value_max"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "chemical_provider_parameter_id", null: false
    t.index ["chemical_provider_parameter_id"], name: "index_parameter_recommendation_chp"
  end

  create_table "parameters", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sort_order", default: 10
    t.decimal "photometer_value_multiplier", default: "1.0"
    t.float "overrange"
    t.float "underrange"
  end

  create_table "systems", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sort_order", default: 10
    t.integer "tag"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_vessel_groups", id: false, force: :cascade do |t|
    t.bigint "vessel_group_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "vessel_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "vessel_id", null: false
    t.string "message", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "assigned_date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["user_id"], name: "index_vessel_comments_on_user_id"
    t.index ["vessel_id"], name: "index_vessel_comments_on_vessel_id"
  end

  create_table "vessel_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vessel_system_parameters", force: :cascade do |t|
    t.bigint "vessel_system_id", null: false
    t.bigint "parameter_id", null: false
    t.float "min_satisfactory"
    t.float "max_satisfactory"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.index ["parameter_id"], name: "index_vessel_system_parameters_on_parameter_id"
    t.index ["vessel_system_id"], name: "index_vessel_system_parameters_on_vessel_system_id"
  end

  create_table "vessel_systems", force: :cascade do |t|
    t.bigint "vessel_id", null: false
    t.bigint "system_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.index ["system_id"], name: "index_vessel_systems_on_system_id"
    t.index ["vessel_id"], name: "index_vessel_systems_on_vessel_id"
  end

  create_table "vessels", force: :cascade do |t|
    t.string "name"
    t.string "company_name"
    t.string "email"
    t.bigint "vessel_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "chemical_provider_id", null: false
    t.bigint "country_id", null: false
    t.index ["chemical_provider_id"], name: "index_vessels_on_chemical_provider_id"
    t.index ["country_id"], name: "index_vessels_on_country_id"
    t.index ["name"], name: "index_vessels_on_name", unique: true
    t.index ["user_id"], name: "index_vessels_on_user_id"
    t.index ["vessel_group_id"], name: "index_vessels_on_vessel_group_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chemical_provider_parameters", "chemical_providers", on_delete: :cascade
  add_foreign_key "chemical_provider_parameters", "parameters"
  add_foreign_key "chemical_provider_parameters", "systems"
  add_foreign_key "import_logs", "measurements_imports"
  add_foreign_key "import_logs", "vessels"
  add_foreign_key "measurements", "vessel_system_parameters"
  add_foreign_key "measurements_imports", "vessels"
  add_foreign_key "parameter_recommendations", "chemical_provider_parameters"
  add_foreign_key "vessel_comments", "users"
  add_foreign_key "vessel_comments", "vessels"
  add_foreign_key "vessel_system_parameters", "parameters"
  add_foreign_key "vessel_system_parameters", "vessel_systems"
  add_foreign_key "vessel_systems", "systems"
  add_foreign_key "vessel_systems", "vessels"
  add_foreign_key "vessels", "chemical_providers"
  add_foreign_key "vessels", "countries"
  add_foreign_key "vessels", "users"
  add_foreign_key "vessels", "vessel_groups"
end
