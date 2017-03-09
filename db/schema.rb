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

ActiveRecord::Schema.define(version: 20170309194006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "memes", force: :cascade do |t|
    t.string   "title",                     null: false
    t.string   "slug",                      null: false
    t.string   "image",                     null: false
    t.integer  "views_count",   default: 0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id"
    t.integer  "price"
    t.integer  "shares_count",  default: 0, null: false
    t.integer  "reports_count", default: 0, null: false
    t.index ["slug"], name: "index_memes_on_slug", unique: true, using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "meme_id"
    t.integer  "user_id"
    t.string   "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_reports_on_meme_id", using: :btree
    t.index ["user_id"], name: "index_reports_on_user_id", using: :btree
  end

  create_table "shares", force: :cascade do |t|
    t.integer  "meme_id"
    t.integer  "user_id"
    t.datetime "sold_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_shares_on_meme_id", using: :btree
    t.index ["user_id"], name: "index_shares_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.integer  "points",             default: 0, null: false
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "views_count",        default: 0, null: false
    t.integer  "shares_count",       default: 0, null: false
    t.integer  "reports_count",      default: 0, null: false
  end

  create_table "views", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_views_on_meme_id", using: :btree
    t.index ["user_id"], name: "index_views_on_user_id", using: :btree
  end

  add_foreign_key "reports", "memes"
  add_foreign_key "reports", "users"
  add_foreign_key "shares", "memes"
  add_foreign_key "shares", "users"
  add_foreign_key "views", "memes"
  add_foreign_key "views", "users"
end
