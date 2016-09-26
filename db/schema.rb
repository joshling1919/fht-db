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

ActiveRecord::Schema.define(version: 20160926200015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string   "esbid"
    t.string   "gsisPlayerId"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "teamAbbr"
    t.string   "opponentTeamAbbr"
    t.string   "position"
    t.float    "percentOwned"
    t.float    "percentOwnedChange"
    t.float    "percentStarted"
    t.float    "percentStartedChange"
    t.integer  "depthChartOrder"
    t.integer  "numAdds"
    t.integer  "numDrops"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "netAdds"
    t.integer  "nflId"
  end

  add_index "players", ["netAdds"], name: "index_players_on_netAdds", using: :btree
  add_index "players", ["nflId"], name: "index_players_on_nflId", using: :btree
  add_index "players", ["percentOwnedChange"], name: "index_players_on_percentOwnedChange", using: :btree

  create_table "update_logs", force: :cascade do |t|
    t.string   "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
