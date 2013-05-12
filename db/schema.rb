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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130511181058) do

  create_table "avantlinks", :force => true do |t|
    t.integer  "gear_item_id"
    t.string   "merchant_name"
    t.string   "product_name"
    t.string   "brand_name"
    t.string   "sale_price"
    t.string   "buy_url"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "permanent"
  end

  add_index "avantlinks", ["gear_item_id"], :name => "index_avantlinks_on_gear_item_id"

  create_table "gear_items", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "post_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "intro"
    t.integer  "front_picture_id"
    t.boolean  "searchable"
  end

  create_table "gear_listings", :force => true do |t|
    t.integer  "gear_item_id"
    t.integer  "gear_list_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "quantity"
    t.string   "group_type"
  end

  add_index "gear_listings", ["group_type"], :name => "index_gear_listings_on_group_type"

  create_table "gear_lists", :force => true do |t|
    t.integer  "trip_id"
    t.text     "intro"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "pictures", :force => true do |t|
    t.integer  "post_id"
    t.integer  "trip_id"
    t.integer  "gear_item_id"
    t.string   "flickr_url"
    t.string   "description"
    t.string   "print_url"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "flickr_small_url"
    t.string   "flickr_medium_url"
    t.string   "flickr_large_url"
    t.string   "name"
  end

  add_index "pictures", ["gear_item_id"], :name => "index_pictures_on_gear_item_id"
  add_index "pictures", ["post_id"], :name => "index_pictures_on_post_id"
  add_index "pictures", ["trip_id"], :name => "index_pictures_on_trip_id"

  create_table "posts", :force => true do |t|
    t.integer  "trip_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "gear_item_id"
    t.integer  "impression_count", :default => 0
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "taggings", :force => true do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taggings", ["post_id", "tag_id"], :name => "index_taggings_on_post_id_and_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.integer  "tag_count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "trips", :force => true do |t|
    t.string   "name"
    t.boolean  "completed"
    t.text     "intro"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "front_picture_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
