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

ActiveRecord::Schema.define(version: 20131002173236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "dish_id"
    t.text     "content"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dishes", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.string   "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_id"
    t.string   "url"
  end

  add_index "dishes", ["category"], name: "index_dishes_on_category", using: :btree
  add_index "dishes", ["name"], name: "index_dishes_on_name", using: :btree
  add_index "dishes", ["price"], name: "index_dishes_on_price", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.integer  "dish_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "cuisine"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "phone"
  end

  add_index "restaurants", ["city"], name: "index_restaurants_on_city", using: :btree
  add_index "restaurants", ["cuisine"], name: "index_restaurants_on_cuisine", using: :btree
  add_index "restaurants", ["zip"], name: "index_restaurants_on_zip", using: :btree

  create_table "user_favorites", force: true do |t|
    t.integer "user_id"
    t.integer "restaurant_id"
    t.integer "dish_id"
  end

  add_index "user_favorites", ["dish_id"], name: "index_user_favorites_on_dish_id", using: :btree
  add_index "user_favorites", ["restaurant_id"], name: "index_user_favorites_on_restaurant_id", using: :btree
  add_index "user_favorites", ["user_id"], name: "index_user_favorites_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "zipcode"
    t.boolean  "is_active",                    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid",              limit: nil
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

end
