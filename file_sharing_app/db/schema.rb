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

ActiveRecord::Schema[7.1].define(version: 2024_08_01_141412) do
  create_table "user_files", force: :cascade do |t|
    t.string "name"
    t.binary "file_data"
    t.date "upload_date"
    t.boolean "public"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "public_url"
    t.string "size"
    t.string "content_type"
    t.index ["public"], name: "index_user_files_on_public"
    t.index ["public_url"], name: "index_user_files_on_public_url", unique: true
    t.index ["upload_date"], name: "index_user_files_on_upload_date"
    t.index ["user_id", "name"], name: "index_user_files_on_user_id_and_name"
    t.index ["user_id"], name: "index_user_files_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "user_files", "users"
end
