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

ActiveRecord::Schema.define(version: 20130927202952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "down_vote_photos", force: true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "down_vote_photos", ["photo_id"], name: "index_down_vote_photos_on_photo_id", using: :btree
  add_index "down_vote_photos", ["user_id"], name: "index_down_vote_photos_on_user_id", using: :btree

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
    t.integer  "state"
    t.string   "zip"
    t.string   "cuisine"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  add_index "restaurants", ["city"], name: "index_restaurants_on_city", using: :btree
  add_index "restaurants", ["cuisine"], name: "index_restaurants_on_cuisine", using: :btree
  add_index "restaurants", ["zip"], name: "index_restaurants_on_zip", using: :btree

  create_table "up_vote_photos", force: true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "up_vote_photos", ["photo_id"], name: "index_up_vote_photos_on_photo_id", using: :btree
  add_index "up_vote_photos", ["user_id"], name: "index_up_vote_photos_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "zipcode"
    t.boolean  "is_active",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
