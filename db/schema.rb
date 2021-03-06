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

ActiveRecord::Schema.define(version: 2019_10_17_045709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "date"
    t.string "status"
    t.integer "who_user_id", null: false
    t.integer "whom_user_id", null: false
    t.bigint "car_id", null: false
    t.index ["car_id"], name: "index_appointments_on_car_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.integer "year", null: false
    t.string "quotation"
    t.string "brand", null: false
    t.string "model", null: false
    t.string "city", null: false
    t.string "condition", null: false
    t.string "kilometer_range", null: false
    t.string "state", null: false
    t.string "variant", null: false
    t.bigint "user_id", null: false
    t.boolean "verified", default: false
    t.boolean "sold", default: false
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.string "condition", null: false
    t.string "cost", null: false
  end

  create_table "kilometer_ranges", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.bigint "brand_id", null: false
    t.index ["brand_id"], name: "index_models_on_brand_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "number", limit: 10, null: false
    t.string "category", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "years", force: :cascade do |t|
    t.integer "start", null: false
    t.integer "end", null: false
  end

  add_foreign_key "appointments", "cars"
  add_foreign_key "cars", "users"
  add_foreign_key "models", "brands"
end
