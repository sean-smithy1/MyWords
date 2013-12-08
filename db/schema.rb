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

ActiveRecord::Schema.define(version: 20130630004503) do

  create_table "lists", force: true do |t|
    t.string   "listname",                           null: false
    t.string   "listtype",   limit: 2, default: "u", null: false
    t.integer  "user_id",                            null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "lists", ["user_id"], name: "index_lists_on_user_id", using: :btree

  create_table "lists_words", id: false, force: true do |t|
    t.integer  "list_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "word_id",    null: false
  end

  add_index "lists_words", ["list_id", "word_id"], name: "index_lists_words_on_list_id_and_word_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "words", force: true do |t|
    t.string   "word",       limit: 35
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "words", ["word"], name: "index_words_on_word", unique: true, using: :btree

end
