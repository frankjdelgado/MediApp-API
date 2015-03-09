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

ActiveRecord::Schema.define(version: 20150205012153) do

  create_table "frequencies", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medication_types", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medications", force: true do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medications", ["name"], name: "index_medications_on_name", unique: true

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatments", force: true do |t|
    t.date     "start"
    t.date     "finish"
    t.string   "hour"
    t.integer  "frequency"
    t.integer  "deleted",       default: 0
    t.integer  "user_id"
    t.integer  "medication_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "treatments", ["medication_id"], name: "index_treatments_on_medication_id"
  add_index "treatments", ["user_id"], name: "index_treatments_on_user_id"

  create_table "units", force: true do |t|
    t.string   "value",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "units", ["value"], name: "index_units_on_value", unique: true

  create_table "users", force: true do |t|
    t.string   "name",                        null: false
    t.string   "email",                       null: false
    t.string   "password_digest"
    t.integer  "role",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
