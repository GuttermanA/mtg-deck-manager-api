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

ActiveRecord::Schema.define(version: 20180404151446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "card_formats", force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "format_id"
    t.boolean "legal", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_formats_on_card_id"
    t.index ["format_id"], name: "index_card_formats_on_format_id"
  end

  create_table "cards", force: :cascade do |t|
    t.citext "name"
    t.string "mana_cost"
    t.integer "cmc"
    t.citext "full_type"
    t.string "rarity"
    t.citext "text"
    t.string "flavor"
    t.string "artist"
    t.string "number"
    t.string "power"
    t.string "toughness"
    t.integer "loyalty"
    t.string "img_url"
    t.integer "multiverse_id"
    t.string "layout"
    t.bigint "magic_set_id"
    t.index ["full_type"], name: "index_cards_on_full_type"
    t.index ["magic_set_id"], name: "index_cards_on_magic_set_id"
    t.index ["name"], name: "index_cards_on_name"
  end

  create_table "cards_colors", id: false, force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "color_id"
    t.index ["card_id"], name: "index_cards_colors_on_card_id"
    t.index ["color_id"], name: "index_cards_colors_on_color_id"
  end

  create_table "cards_magic_sets", id: false, force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "magic_set_id"
    t.index ["card_id"], name: "index_cards_magic_sets_on_card_id"
    t.index ["magic_set_id"], name: "index_cards_magic_sets_on_magic_set_id"
  end

  create_table "cards_subtypes", id: false, force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "subtype_id"
    t.index ["card_id"], name: "index_cards_subtypes_on_card_id"
    t.index ["subtype_id"], name: "index_cards_subtypes_on_subtype_id"
  end

  create_table "cards_supertypes", id: false, force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "supertype_id"
    t.index ["card_id"], name: "index_cards_supertypes_on_card_id"
    t.index ["supertype_id"], name: "index_cards_supertypes_on_supertype_id"
  end

  create_table "cards_types", id: false, force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "type_id"
    t.index ["card_id"], name: "index_cards_types_on_card_id"
    t.index ["type_id"], name: "index_cards_types_on_type_id"
  end

  create_table "collections", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "card_id"
    t.bigint "magic_set_id"
    t.integer "count"
    t.boolean "premium", default: false
    t.string "condition"
    t.boolean "wishlist", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_collections_on_card_id"
    t.index ["magic_set_id"], name: "index_collections_on_magic_set_id"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deck_cards", force: :cascade do |t|
    t.integer "deck_id"
    t.bigint "card_id"
    t.integer "card_count"
    t.boolean "sideboard", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_deck_cards_on_card_id"
    t.index ["deck_id"], name: "index_deck_cards_on_deck_id"
  end

  create_table "decks", force: :cascade do |t|
    t.citext "name"
    t.string "creator"
    t.citext "archtype"
    t.bigint "format_id"
    t.bigint "user_id"
    t.integer "total_cards"
    t.integer "mainboard"
    t.integer "sideboard"
    t.boolean "tournament", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archtype"], name: "index_decks_on_archtype"
    t.index ["format_id"], name: "index_decks_on_format_id"
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "formats", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magic_sets", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.date "release_date"
    t.string "block"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subtypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supertypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
