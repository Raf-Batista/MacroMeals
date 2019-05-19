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

ActiveRecord::Schema.define(version: 2019_05_17_001656) do

  create_table "ingredients", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "metric"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
  end

  create_table "recipe_ratings", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "user_id"
    t.integer "rating"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.integer "prep_time"
    t.integer "cook_time"
    t.integer "servings"
    t.integer "protien"
    t.integer "carbs"
    t.integer "fat"
    t.text "directions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
