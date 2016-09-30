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

ActiveRecord::Schema.define(version: 20160930062249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string   "esbid"
    t.string   "gsis_player_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "team_abbr"
    t.string   "opponent_team_abbr"
    t.string   "position"
    t.float    "percent_owned"
    t.float    "percent_owned_change"
    t.float    "percent_started"
    t.float    "percent_started_change"
    t.integer  "depth_chart_order"
    t.integer  "num_adds"
    t.integer  "num_drops"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "net_adds"
    t.integer  "nfl_id"
  end

  add_index "players", ["net_adds"], name: "index_players_on_net_adds", using: :btree
  add_index "players", ["nfl_id"], name: "index_players_on_nfl_id", using: :btree
  add_index "players", ["percent_owned"], name: "index_players_on_percent_owned", using: :btree
  add_index "players", ["percent_owned_change"], name: "index_players_on_percent_owned_change", using: :btree

  create_table "update_logs", force: :cascade do |t|
    t.string   "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
