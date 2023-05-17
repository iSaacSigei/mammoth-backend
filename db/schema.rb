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

ActiveRecord::Schema[7.0].define(version: 2023_05_17_105805) do
  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "token"
  end

  create_table "lands", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.decimal "price"
    t.string "location"
    t.string "image"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.integer "admin_id"
    t.string "parcel_id", limit: 8
    t.index ["admin_id"], name: "index_lands_on_admin_id"
    t.index ["parcel_id"], name: "index_lands_on_parcel_id"
    t.index ["user_id"], name: "index_lands_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "state"
    t.string "city"
    t.string "street_adress"
    t.string "avatar"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.string "token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
  end

  add_foreign_key "lands", "admins"
  add_foreign_key "lands", "users"
  add_foreign_key "profiles", "users"
end
