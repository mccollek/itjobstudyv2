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

ActiveRecord::Schema.define(version: 20140110142043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "area_types", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", force: true do |t|
    t.integer  "code"
    t.integer  "area_type_id"
    t.string   "name"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bls_column_mappers", force: true do |t|
    t.string   "web_column_name"
    t.string   "application_object_attribute"
    t.string   "application_object"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "data_type_id"
  end

  create_table "data_types", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.integer  "footnote_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_category"
  end

  add_index "data_types", ["code"], name: "index_data_types_on_code", using: :btree
  add_index "data_types", ["data_category"], name: "index_data_types_on_data_category", using: :btree

  create_table "industries", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.integer  "display_level"
    t.boolean  "selectable"
    t.integer  "sort_sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ce_code"
  end

  create_table "occupation_groups", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupational_statistics", force: true do |t|
    t.integer  "seasonal_id"
    t.integer  "year"
    t.string   "period"
    t.integer  "area_id"
    t.integer  "industry_id"
    t.integer  "occupation_id"
    t.integer  "data_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "value"
    t.string   "original_series"
  end

  add_index "occupational_statistics", ["area_id"], name: "index_occupational_statistics_on_area_id", using: :btree
  add_index "occupational_statistics", ["data_type_id"], name: "index_occupational_statistics_on_data_type_id", using: :btree
  add_index "occupational_statistics", ["industry_id"], name: "index_occupational_statistics_on_industry_id", using: :btree
  add_index "occupational_statistics", ["occupation_id"], name: "index_occupational_statistics_on_occupation_id", using: :btree

  create_table "occupations", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.integer  "display_level"
    t.boolean  "selectable"
    t.integer  "sort_sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_criteria", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "report_id"
    t.integer  "criteriable_id"
    t.string   "criteriable_type"
  end

  create_table "reports", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasonals", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "state_msas", force: true do |t|
    t.integer  "state_id"
    t.integer  "msa_code"
    t.string   "msa_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
