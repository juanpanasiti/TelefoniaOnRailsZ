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

ActiveRecord::Schema.define(version: 20171209143124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.integer  "access_level",           default: 0,  null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "bill_headers", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "order"
    t.string   "type_field"
    t.string   "type_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bill_items", force: :cascade do |t|
    t.integer  "bill_header_id"
    t.string   "concept_id"
    t.string   "concept_description"
    t.integer  "quantity_column"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["bill_header_id"], name: "index_bill_items_on_bill_header_id", using: :btree
  end

  create_table "cells", force: :cascade do |t|
    t.integer  "internal_id"
    t.integer  "row_id"
    t.string   "primary_color"
    t.string   "secondary_color"
    t.string   "state"
    t.integer  "position"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["internal_id"], name: "index_cells_on_internal_id", using: :btree
    t.index ["row_id"], name: "index_cells_on_row_id", using: :btree
  end

  create_table "delegations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.text     "footnote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_models", force: :cascade do |t|
    t.string   "mark"
    t.string   "device_name"
    t.string   "device_code"
    t.string   "accessories"
    t.text     "details"
    t.string   "type_sim"
    t.string   "specs_link"
    t.boolean  "slot_sd"
    t.string   "category"
    t.string   "band"
    t.string   "os"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "device_model_id"
    t.string   "imei"
    t.integer  "line_id"
    t.boolean  "is_personal"
    t.string   "state"
    t.string   "failure"
    t.datetime "check_date"
    t.text     "details"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["device_model_id"], name: "index_devices_on_device_model_id", using: :btree
    t.index ["line_id"], name: "index_devices_on_line_id", using: :btree
  end

  create_table "internals", force: :cascade do |t|
    t.string   "name"
    t.string   "prefix"
    t.string   "number"
    t.integer  "office_id"
    t.text     "footNote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_internals_on_office_id", using: :btree
  end

  create_table "lines", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "number"
    t.string   "has_inet"
    t.string   "state"
    t.string   "type_sim"
    t.boolean  "has_sms_pack"
    t.datetime "check_date"
    t.text     "notes"
    t.string   "bill_account"
    t.string   "vpn_link"
    t.integer  "limit_offnet"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["person_id"], name: "index_lines_on_person_id", using: :btree
  end

  create_table "mail_accounts", force: :cascade do |t|
    t.string   "email"
    t.string   "pass"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_mail_accounts_on_person_id", using: :btree
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "locations"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "offices", force: :cascade do |t|
    t.string   "name"
    t.text     "footnote"
    t.integer  "delegation_id"
    t.integer  "parent_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["delegation_id"], name: "index_offices_on_delegation_id", using: :btree
    t.index ["parent_id"], name: "index_offices_on_parent_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "dni"
    t.boolean  "alert"
    t.text     "accounts"
    t.text     "footnote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "office_id"
    t.index ["office_id"], name: "index_people_on_office_id", using: :btree
  end

  create_table "rows", force: :cascade do |t|
    t.integer  "position"
    t.integer  "sheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sheet_id"], name: "index_rows_on_sheet_id", using: :btree
  end

  create_table "selector_settings", force: :cascade do |t|
    t.string   "name"
    t.string   "id_name"
    t.string   "selector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sheets", force: :cascade do |t|
    t.integer  "position"
    t.integer  "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_sheets_on_node_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.text     "detail"
    t.string   "state"
    t.string   "type_task"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "access_level",           default: 0,  null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bill_items", "bill_headers"
  add_foreign_key "cells", "internals"
  add_foreign_key "cells", "rows"
  add_foreign_key "devices", "device_models"
  add_foreign_key "devices", "lines"
  add_foreign_key "internals", "offices"
  add_foreign_key "lines", "people"
  add_foreign_key "mail_accounts", "people"
  add_foreign_key "offices", "delegations"
  add_foreign_key "people", "offices"
  add_foreign_key "rows", "sheets"
  add_foreign_key "sheets", "nodes"
end
