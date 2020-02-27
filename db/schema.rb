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

ActiveRecord::Schema.define(version: 2020_02_26_234132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "assets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.jsonb "file_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audiosets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "description"
    t.string "readme"
    t.uuid "geomap_id"
    t.jsonb "logo_data"
    t.jsonb "background_data"
    t.string "display_mode"
    t.float "bpm"
    t.integer "quantize"
    t.string "play_mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "geomap_url"
    t.float "geomap_lambda"
    t.float "geomap_vshift"
    t.float "geomap_hshift"
    t.float "geomap_scale"
    t.string "publish_path"
    t.uuid "parent_id"
    t.string "audioset_type"
    t.string "children"
    t.float "geomap_center_x"
    t.float "geomap_center_y"
    t.index ["geomap_id"], name: "index_audiosets_on_geomap_id"
    t.index ["slug"], name: "index_audiosets_on_slug", unique: true
  end

  create_table "clips", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "audioset_id"
    t.uuid "track_id"
    t.string "name", null: false
    t.string "slug", null: false
    t.jsonb "cover_data"
    t.jsonb "audio_mp3_data"
    t.jsonb "audio_wav_data"
    t.string "description"
    t.string "title"
    t.string "album"
    t.string "artist"
    t.string "year"
    t.string "country"
    t.string "place"
    t.string "readme"
    t.float "xpos"
    t.float "ypos"
    t.string "color"
    t.string "key"
    t.float "beats"
    t.float "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "audio_ogg_data"
    t.jsonb "cover2_data"
    t.index ["audioset_id", "slug"], name: "index_clips_on_audioset_id_and_slug", unique: true
    t.index ["audioset_id"], name: "index_clips_on_audioset_id"
    t.index ["track_id"], name: "index_clips_on_track_id"
  end

  create_table "geomaps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.jsonb "map_data"
    t.float "lambda"
    t.float "vshift"
    t.float "hshift"
    t.float "scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.uuid "audioset_id"
    t.bigint "admin_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_permissions_on_admin_user_id"
    t.index ["audioset_id"], name: "index_permissions_on_audioset_id"
  end

  create_table "shares", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "previous_id"
    t.string "content_type"
    t.text "content"
    t.boolean "published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "audioset_id"
    t.integer "position", default: 0, null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.string "color"
    t.float "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audioset_id", "position"], name: "index_tracks_on_audioset_id_and_position", unique: true
    t.index ["audioset_id", "slug"], name: "index_tracks_on_audioset_id_and_slug", unique: true
    t.index ["audioset_id"], name: "index_tracks_on_audioset_id"
  end

  add_foreign_key "audiosets", "geomaps"
  add_foreign_key "clips", "audiosets"
  add_foreign_key "clips", "tracks"
  add_foreign_key "permissions", "admin_users"
  add_foreign_key "permissions", "audiosets"
  add_foreign_key "tracks", "audiosets"
end
