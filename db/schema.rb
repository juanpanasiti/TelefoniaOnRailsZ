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

ActiveRecord::Schema.define(version: 20170301021424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delegations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.text     "footnote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "selector_settings", force: :cascade do |t|
    t.string   "name"
    t.string   "id_name"
    t.string   "selector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "lines", "people"
  add_foreign_key "mail_accounts", "people"
  add_foreign_key "offices", "delegations"
  add_foreign_key "people", "offices"
end
