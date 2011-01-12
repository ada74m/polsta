# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081021093723) do

  create_table "responses", :force => true do |t|
    t.integer  "user_id"
    t.string   "guid",       :limit => 32, :null => false
    t.integer  "version_id",               :null => false
    t.text     "answers",                  :null => false
    t.string   "remote_ip",  :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "surveys", :force => true do |t|
    t.string   "name",                                                         :null => false
    t.string   "url_name",                                                     :null => false
    t.integer  "user_id"
    t.integer  "responses_count",               :default => 0
    t.string   "status",          :limit => 20, :default => "never published"
    t.string   "embedding_id",    :limit => 32
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rss_id",          :limit => 32
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "account_name",                          :null => false
    t.string   "password_salt"
    t.string   "password_hash"
    t.integer  "credits",                :default => 0, :null => false
    t.integer  "has_accepted_terms",     :default => 0, :null => false
    t.integer  "wishes_to_receive_news", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", :force => true do |t|
    t.integer  "survey_id",                      :null => false
    t.integer  "position"
    t.integer  "state",           :default => 1
    t.text     "design"
    t.integer  "responses_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
