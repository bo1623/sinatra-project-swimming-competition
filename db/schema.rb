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

ActiveRecord::Schema.define(version: 5) do

  create_table "events", force: :cascade do |t|
    t.string "stroke"
    t.integer "distance"
    t.string "gender"
    t.string "division"
    t.string "name"
    t.time "meet_record"
  end

  create_table "swimmer_events", force: :cascade do |t|
    t.integer "swimmer_id"
    t.integer "event_id"
  end

  create_table "swimmers", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.integer "team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "teamname"
    t.string "password_digest"
  end

  create_table "timings", force: :cascade do |t|
    t.time "personal_best"
    t.integer "event_id"
    t.integer "swimmer_id"
  end

end
