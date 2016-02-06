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

ActiveRecord::Schema.define(version: 20160206162235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id",            null: false
    t.integer  "package_id",         null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "active"
    t.string   "stripe_customer_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "venue_id",   null: false
    t.string   "user_id",    null: false
    t.string   "band_count", null: false
    t.string   "price",      null: false
    t.string   "status",     null: false
    t.string   "color",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "venue_count",     null: false
    t.integer  "promotion_count", null: false
    t.decimal  "band_fee",        null: false
    t.decimal  "price",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name"
    t.string   "ad_location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_id"
    t.string   "description"
    t.boolean  "active"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "user_venues", force: :cascade do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.integer  "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_venues", ["user_id"], name: "index_users_venues_on_user_id", using: :btree
  add_index "user_venues", ["venue_id"], name: "index_users_venues_on_venue_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",                              null: false
    t.string   "uid",                    default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.boolean  "active",                 default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state",      limit: 2
    t.string   "zip_code",   limit: 5
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "active"
    t.string   "url"
    t.string   "category"
  end

end
