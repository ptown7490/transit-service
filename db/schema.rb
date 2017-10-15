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

ActiveRecord::Schema.define(version: 20171014212137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "route_directions", force: :cascade do |t|
    t.integer "route_id"
    t.integer "direction_id"
    t.string "direction_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_route_directions_on_route_id"
  end

  create_table "routes", force: :cascade do |t|
    t.integer "agency_id"
    t.string "local_id"
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_routes_on_agency_id"
  end

  create_table "stop_times", force: :cascade do |t|
    t.integer "stop_id"
    t.integer "trip_id"
    t.integer "stop_sequence"
    t.string "arrival_time"
    t.string "depart_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stop_id"], name: "index_stop_times_on_stop_id"
    t.index ["trip_id"], name: "index_stop_times_on_trip_id"
  end

  create_table "stops", force: :cascade do |t|
    t.integer "agency_id"
    t.string "local_id"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_stops_on_agency_id"
    t.index ["local_id"], name: "index_stops_on_local_id"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "route_direction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "local_id"
    t.integer "block_id"
    t.index ["block_id"], name: "index_trips_on_block_id"
    t.index ["local_id"], name: "index_trips_on_local_id"
    t.index ["route_direction_id"], name: "index_trips_on_route_direction_id"
  end

end
