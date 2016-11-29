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

ActiveRecord::Schema.define(version: 20150701174723) do

  create_table "mr_torques", force: :cascade do |t|
    t.string   "todays_quote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_audit_trail_audits", force: :cascade do |t|
    t.integer  "simple_audit_trailable_id"
    t.string   "simple_audit_trailable_type"
    t.integer  "who_id"
    t.text     "from"
    t.text     "to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "unchanged"
  end

  create_table "tinas", force: :cascade do |t|
    t.integer  "ladies"
    t.integer  "badonkadonks"
    t.string   "mushy_snugglebites"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
