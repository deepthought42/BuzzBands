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

ActiveRecord::Schema.define(version: 20160324050948) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id",            limit: 4,   null: false
    t.integer  "package_id",         limit: 4,   null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "active",             limit: 1
    t.string   "stripe_customer_id", limit: 255
  end

  create_table "orders", force: :cascade do |t|
    t.string   "venue_id",   limit: 255, null: false
    t.string   "user_id",    limit: 255, null: false
    t.string   "band_count", limit: 255, null: false
    t.string   "price",      limit: 255, null: false
    t.string   "status",     limit: 255, null: false
    t.string   "color",      limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name",            limit: 255,                null: false
    t.integer  "venue_count",     limit: 4,                  null: false
    t.integer  "promotion_count", limit: 4,                  null: false
    t.decimal  "band_fee",                    precision: 10, null: false
    t.decimal  "price",                       precision: 10, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "ad_location", limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id",    limit: 4
    t.string   "description", limit: 255
    t.boolean  "active",      limit: 1
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree

  create_table "scans", force: :cascade do |t|
    t.integer  "venue_id",   limit: 4
    t.string   "uuid",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "scans", ["venue_id"], name: "index_scans_on_venue_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               limit: 255,                  null: false
    t.string   "uid",                    limit: 255,   default: "",   null: false
    t.string   "encrypted_password",     limit: 255,   default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.string   "email",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                   limit: 4
    t.boolean  "active",                 limit: 1,     default: true
    t.integer  "account_id",             limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "users_venues", force: :cascade do |t|
    t.integer  "venue_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "role",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "users_venues", ["user_id"], name: "index_users_venues_on_user_id", using: :btree
  add_index "users_venues", ["venue_id"], name: "index_users_venues_on_venue_id", using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 2
    t.string   "zip_code",   limit: 5
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "active",     limit: 1
    t.string   "url",        limit: 255
    t.string   "category",   limit: 255
    t.integer  "account_id", limit: 4
    t.float    "longitude",  limit: 24
    t.float    "latitude",   limit: 24
  end

end
