ActiveRecord::Schema[7.0].define(version: 2023_04_11_165723) do
  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
  end

  add_foreign_key "profiles", "users"
end
