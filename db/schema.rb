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

ActiveRecord::Schema.define(version: 20150527062923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_twitter_rate_limit_statuses", force: :cascade do |t|
    t.integer  "remaining_user_info_requests",     default: 180
    t.integer  "remaining_user_timeline_requests", default: 180
    t.integer  "remaining_rate_limit_requests",    default: 180
    t.datetime "user_info_reset_time"
    t.datetime "user_timeline_reset_time"
    t.datetime "rate_limit_reset_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artist_tracker_keys", force: :cascade do |t|
    t.string "facebook_access_token", limit: 255
  end

  create_table "artists", force: :cascade do |t|
    t.text     "twitter_url"
    t.text     "facebook_url"
    t.text     "soundcloud_url"
    t.text     "songkick_url"
    t.string   "name",           limit: 255, null: false
    t.string   "music_genre",    limit: 255, null: false
    t.string   "country",        limit: 255
    t.string   "city",           limit: 255
    t.string   "state",          limit: 255
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["name", "music_genre"], name: "index_artists_on_name_and_music_genre", unique: true, using: :btree

  create_table "concerts", force: :cascade do |t|
    t.integer  "songkick_account_id",             null: false
    t.integer  "songkick_id",                     null: false
    t.integer  "age_restriction"
    t.float    "lat"
    t.float    "long"
    t.text     "event_name",                      null: false
    t.text     "url",                             null: false
    t.string   "city",                limit: 255, null: false
    t.string   "state",               limit: 255
    t.string   "country",             limit: 255, null: false
    t.datetime "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concerts", ["songkick_account_id"], name: "index_concerts_on_songkick_account_id", using: :btree

  create_table "facebook_accounts", force: :cascade do |t|
    t.integer  "account_owner_id"
    t.string   "account_owner_type", limit: 255
    t.integer  "likes_count"
    t.string   "facebook_id",        limit: 255, null: false
    t.string   "about_info",         limit: 255
    t.string   "hometown",           limit: 255
    t.string   "genre",              limit: 255
    t.text     "bio"
    t.text     "banner_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_accounts", ["account_owner_id", "account_owner_type"], name: "facebook_accounts_on_account_owner_idx", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "facebook_account_id",             null: false
    t.integer  "shares_count"
    t.integer  "likes_count"
    t.integer  "comments_count"
    t.string   "facebook_id",         limit: 255, null: false
    t.text     "message"
    t.datetime "posted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["facebook_account_id"], name: "index_posts_on_facebook_account_id", using: :btree

  create_table "songkick_accounts", force: :cascade do |t|
    t.integer  "account_owner_id"
    t.string   "account_owner_type", limit: 255
    t.integer  "songkick_id",                    null: false
    t.integer  "total_concerts"
    t.string   "display_name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songkick_accounts", ["account_owner_id", "account_owner_type"], name: "songkick_accounts_on_account_owner_idx", unique: true, using: :btree

  create_table "soundcloud_accounts", force: :cascade do |t|
    t.integer  "account_owner_id"
    t.string   "account_owner_type", limit: 255
    t.integer  "soundcloud_id",                  null: false
    t.integer  "total_tracks"
    t.integer  "total_followers"
    t.integer  "total_following"
    t.string   "display_name",       limit: 255, null: false
    t.string   "country",            limit: 255
    t.string   "city",               limit: 255
    t.text     "api_url"
    t.text     "url",                            null: false
    t.text     "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "soundcloud_accounts", ["account_owner_id", "account_owner_type"], name: "soundcloud_accounts_on_account_owner_idx", unique: true, using: :btree

  create_table "tracks", force: :cascade do |t|
    t.integer  "soundcloud_account_id"
    t.integer  "soundcloud_id",                     null: false
    t.integer  "playback_count"
    t.integer  "download_count"
    t.integer  "comments_count"
    t.integer  "favorited_count"
    t.integer  "duration"
    t.string   "genre",                 limit: 255
    t.text     "purchase_url"
    t.text     "title",                             null: false
    t.text     "url"
    t.text     "artwork_url"
    t.text     "waveform_url"
    t.text     "stream_url"
    t.text     "download_url"
    t.text     "embedded_html"
    t.datetime "uploaded_date",                     null: false
    t.boolean  "is_commentable",                    null: false
    t.boolean  "is_downloadable",                   null: false
    t.boolean  "is_streamable",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["soundcloud_account_id"], name: "index_tracks_on_soundcloud_account_id", using: :btree

  create_table "tweets", force: :cascade do |t|
    t.integer  "twitter_account_id",                 null: false
    t.integer  "retweet_count"
    t.integer  "favorites_count"
    t.boolean  "is_retweet"
    t.string   "twitter_id",             limit: 255, null: false
    t.string   "retweet_hashtags",                                array: true
    t.string   "retweet_user_mentions",                           array: true
    t.string   "hashtags",                                        array: true
    t.string   "user_mentions",                                   array: true
    t.text     "message"
    t.text     "attachment_url"
    t.text     "retweet_attachment_url"
    t.datetime "tweeted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "language"
    t.boolean  "truncated"
  end

  add_index "tweets", ["twitter_account_id"], name: "index_tweets_on_twitter_account_id", using: :btree

  create_table "twitter_accounts", force: :cascade do |t|
    t.integer  "account_owner_id"
    t.string   "account_owner_type",           limit: 255
    t.integer  "statuses_count"
    t.integer  "followers_count"
    t.integer  "friends_count"
    t.integer  "favorites_count"
    t.text     "twitter_uid",                              null: false
    t.string   "oauth_token",                  limit: 255
    t.string   "oauth_secret",                 limit: 255
    t.string   "username",                     limit: 255, null: false
    t.string   "location",                     limit: 255
    t.string   "language",                     limit: 255
    t.string   "profile_background_color",     limit: 255
    t.text     "profile_background_image_url"
    t.text     "profile_banner_url"
    t.text     "tagline"
    t.text     "profile_pic_url"
    t.boolean  "verified"
    t.datetime "join_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "display_name"
    t.text     "profile_link_color"
    t.boolean  "profile_use_background_image"
    t.text     "status"
    t.text     "time_zone"
    t.text     "url"
  end

  add_index "twitter_accounts", ["account_owner_id", "account_owner_type"], name: "twitter_accounts_on_account_owner_idx", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_artists", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "artist_id"
  end

  add_index "users_artists", ["user_id", "artist_id"], name: "index_users_artists_on_user_id_and_artist_id", unique: true, using: :btree

end
