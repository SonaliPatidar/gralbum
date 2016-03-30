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

ActiveRecord::Schema.define(version: 20160328110124) do

  create_table "albums", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "publish"
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "albums", ["user_id"], name: "index_albums_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "comment_name", limit: 255
    t.integer  "user_id",      limit: 4
    t.integer  "photo_id",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["photo_id"], name: "index_comments_on_photo_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "employee_sessions", force: :cascade do |t|
    t.string   "user_id",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "frist_name",  limit: 255
    t.string   "last_name",   limit: 255
    t.string   "email",       limit: 255
    t.string   "designation", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "password",    limit: 255
  end

  create_table "photos", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "user_id",            limit: 4
    t.integer  "album_id",           limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "cover_photo",                    default: false
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "todo_histories", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "todo_id",     limit: 4
  end

  add_index "todo_histories", ["todo_id"], name: "index_todo_histories_on_todo_id", using: :btree

  create_table "todos", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "email",       limit: 255
    t.text     "description", limit: 65535
    t.string   "status",      limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "public",                    default: false
    t.integer  "employee_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name",  limit: 255
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "team",       limit: 255
    t.string   "role",       limit: 255
    t.boolean  "approve",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

end
