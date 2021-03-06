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

ActiveRecord::Schema.define(:version => 20110508211959) do

  create_table "flags", :force => true do |t|
    t.string   "species"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hostflags", :force => true do |t|
    t.integer  "host_id"
    t.integer  "flag_id"
    t.string   "description"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", :force => true do |t|
    t.string   "mac"
    t.string   "ip"
    t.string   "hostname"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ip_numeric", :default => 0, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "account"
    t.string   "email"
    t.string   "adress"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pin",        :default => 0, :null => false
  end

end
