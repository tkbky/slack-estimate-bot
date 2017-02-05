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

ActiveRecord::Schema.define(version: 20170205020936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "estimates", force: :cascade do |t|
    t.integer  "point",         default: 0,                    null: false
    t.integer  "story_id"
    t.string   "user_slack_id",                                null: false
    t.string   "status",        default: "pending",            null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.uuid     "uuid",          default: "uuid_generate_v4()"
  end

  add_index "estimates", ["story_id"], name: "index_estimates_on_story_id", using: :btree
  add_index "estimates", ["user_slack_id", "story_id"], name: "index_estimates_on_user_slack_id_and_story_id", unique: true, using: :btree
  add_index "estimates", ["uuid"], name: "index_estimates_on_uuid", unique: true, using: :btree

  create_table "stories", force: :cascade do |t|
    t.string   "title",      null: false
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stories", ["team_id"], name: "index_stories_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "slack_id",                                 null: false
    t.string   "name",                                     null: false
    t.string   "incoming_webhook_url",                     null: false
    t.string   "incoming_webhook_channel",                 null: false
    t.string   "incoming_webhook_config_url",              null: false
    t.string   "bot_user_id",                 default: "", null: false
    t.string   "bot_access_token",            default: "", null: false
    t.string   "access_token",                             null: false
    t.string   "scope",                                    null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "teams", ["slack_id", "incoming_webhook_channel"], name: "index_teams_on_slack_id_and_incoming_webhook_channel", unique: true, using: :btree

  add_foreign_key "estimates", "stories"
  add_foreign_key "stories", "teams"
end
