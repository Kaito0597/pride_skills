# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_24_202033) do

  create_table "ability_scores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "character_id"
    t.string "name"
    t.string "abbreviation"
    t.integer "score", default: 10
    t.index ["character_id"], name: "index_ability_scores_on_character_id"
  end

  create_table "characters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "class_name", default: "Barbarian"
    t.integer "level", default: 1
    t.integer "skill_points", default: 0
    t.boolean "jack_of_all_trades", default: false
    t.bigint "game_id"
    t.index ["game_id"], name: "index_characters_on_game_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "games", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "join_code"
    t.date "ingame_datetime", default: "2020-06-01"
  end

  create_table "player_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "game_id"
    t.boolean "is_gamemaster", default: false
    t.integer "selected_character_id"
    t.index ["game_id"], name: "index_player_data_on_game_id"
    t.index ["user_id"], name: "index_player_data_on_user_id"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "character_id"
    t.string "name"
    t.string "ability_score"
    t.integer "score", default: 0
    t.integer "points_invested", default: 0
    t.boolean "expertise", default: false
    t.boolean "proficiency", default: false
    t.index ["character_id"], name: "index_skills_on_character_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "selected_game_id"
    t.boolean "is_admin", default: false
  end

end
