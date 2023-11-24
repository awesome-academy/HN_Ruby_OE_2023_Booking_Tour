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

ActiveRecord::Schema[7.0].define(version: 2023_11_24_072342) do
  create_table "bookings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "booking_date"
    t.string "phone"
    t.date "start_date"
    t.date "end_date"
    t.integer "numbers_people"
    t.decimal "total_amount", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tour_details_id"
    t.bigint "users_id"
    t.index ["tour_details_id"], name: "index_bookings_on_tour_details_id"
    t.index ["users_id"], name: "index_bookings_on_users_id"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follow_tours", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "users_id", null: false
    t.bigint "tours_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tours_id"], name: "index_follow_tours_on_tours_id"
    t.index ["users_id"], name: "index_follow_tours_on_users_id"
  end

  create_table "image_reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "reviews_id"
    t.index ["reviews_id"], name: "index_image_reviews_on_reviews_id"
  end

  create_table "image_tours", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tours_id"
    t.index ["tours_id"], name: "index_image_tours_on_tours_id"
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.bigint "tours_id"
    t.index ["tours_id"], name: "index_reviews_on_tours_id"
    t.index ["users_id"], name: "index_reviews_on_users_id"
  end

  create_table "tour_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10
    t.integer "max_people"
    t.string "description"
    t.string "start_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tours_id"
    t.index ["tours_id"], name: "index_tour_details_on_tours_id"
  end

  create_table "tours", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "time_duration"
    t.string "hagtag"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "categories_id"
    t.index ["categories_id"], name: "index_tours_on_categories_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.string "image", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "tour_details", column: "tour_details_id"
  add_foreign_key "bookings", "users", column: "users_id"
  add_foreign_key "follow_tours", "tours", column: "tours_id"
  add_foreign_key "follow_tours", "users", column: "users_id"
  add_foreign_key "image_reviews", "reviews", column: "reviews_id"
  add_foreign_key "image_tours", "tours", column: "tours_id"
  add_foreign_key "reviews", "tours", column: "tours_id"
  add_foreign_key "reviews", "users", column: "users_id"
  add_foreign_key "tour_details", "tours", column: "tours_id"
  add_foreign_key "tours", "categories", column: "categories_id"
end
