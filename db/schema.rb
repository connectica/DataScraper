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

ActiveRecord::Schema.define(version: 20150916144427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "json1"
    t.string   "json2"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ecdata", id: false, force: :cascade do |t|
    t.integer "ecid"
    t.integer "orgno"
    t.string  "legal_name",             limit: 255
    t.string  "popular_name",           limit: 255
    t.string  "street_id",              limit: 255
    t.string  "street",                 limit: 255
    t.string  "houseno",                limit: 255
    t.string  "entrance",               limit: 255
    t.string  "zip",                    limit: 255
    t.string  "city",                   limit: 255
    t.string  "post_address",           limit: 255
    t.string  "post_zip",               limit: 255
    t.string  "post_city",              limit: 255
    t.string  "municipality",           limit: 255
    t.string  "municipality_code",      limit: 255
    t.string  "county",                 limit: 255
    t.string  "county_code",            limit: 255
    t.string  "lon",                    limit: 255
    t.string  "lat",                    limit: 255
    t.string  "geoquality",             limit: 255
    t.string  "phone",                  limit: 255
    t.string  "fax",                    limit: 255
    t.string  "mobile",                 limit: 255
    t.string  "email",                  limit: 255
    t.string  "url",                    limit: 255
    t.string  "nace_1",                 limit: 255
    t.string  "nacetitle_1",            limit: 255
    t.string  "nace_2",                 limit: 255
    t.string  "nacetitle_2",            limit: 255
    t.string  "orgtype",                limit: 255
    t.string  "legal_enterprise_orgno", limit: 255
  end

  create_table "firms", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "enirodata"
    t.integer  "orgnr"
    t.string   "OpplysningenData"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
