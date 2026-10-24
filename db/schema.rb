ActiveRecord::Schema[7.1].define(version: 2026_10_16_022753) do
  enable_extension "plpgsql"

  create_table "folders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "body"
    t.bigint "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id"], name: "index_notes_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.text "description"
    t.boolean "pinned", default: false, null: false
    t.bigint "folder_id"
    t.index ["folder_id"], name: "index_words_on_folder_id"
    t.index ["user_id"], name: "index_words_on_user_id"
  end

  add_foreign_key "folders", "users"
  add_foreign_key "notes", "words"
  add_foreign_key "words", "folders"
  add_foreign_key "words", "users"
end