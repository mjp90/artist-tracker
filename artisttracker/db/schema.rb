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

ActiveRecord::Schema.define(version: 20140618114137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.string   "name",        null: false
    t.string   "country"
    t.string   "city"
    t.string   "state"
    t.string   "music_genre", null: false
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitter_accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "artist_id"
    t.integer  "statuses_count"
    t.integer  "followers_count"
    t.string   "username"
    t.string   "location"
    t.string   "language"
    t.text     "tagline"
    t.text     "profile_pic_url"
    t.datetime "join_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twitter_accounts", ["artist_id"], name: "twitter_accounts_artist_id_idx", using: :btree
  add_index "twitter_accounts", ["user_id"], name: "twitter_accounts_user_id_idx", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_artists", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "artist_id"
  end

end
