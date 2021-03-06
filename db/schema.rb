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

ActiveRecord::Schema.define(:version => 20121118161853) do

  create_table "comments", :force => true do |t|
    t.string   "body"
    t.integer  "document_id"
    t.string   "commenter"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "document_histories", :force => true do |t|
    t.integer  "document_id"
    t.string   "document_name"
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "change_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "filename"
    t.string   "description"
    t.binary   "contents"
    t.string   "owner"
    t.integer  "authorizationlevel"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
    t.float    "rating_avg"
    t.integer  "rating_count"
  end

  create_table "sessions", :force => true do |t|
    t.string   "sessionid"
    t.integer  "userindex"
    t.datetime "lastupdate"
  end

  create_table "users", :force => true do |t|
    t.string   "userid"
    t.string   "password_digest"
    t.string   "username"
    t.integer  "authorizationlevel"
    t.integer  "faildattempts"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

end
