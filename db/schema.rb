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

ActiveRecord::Schema.define(version: 20170724191501) do

  create_table "contests", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "difficulty", null: false
    t.datetime "startDate", null: false
    t.datetime "endDate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contests_problems", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "contest_id", null: false
    t.integer "problem_id", null: false
    t.index ["contest_id"], name: "index_contests_problems_on_contest_id"
    t.index ["problem_id"], name: "index_contests_problems_on_problem_id"
  end

  create_table "contests_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "contest_id", null: false
    t.integer "user_id", null: false
    t.integer "ok", default: 0, null: false
    t.integer "wa", default: 0, null: false
    t.integer "re", default: 0, null: false
    t.integer "tle", default: 0, null: false
    t.integer "ce", default: 0, null: false
    t.index ["contest_id", "user_id"], name: "index_contests_users_on_contest_id_and_user_id", unique: true
    t.index ["contest_id"], name: "index_contests_users_on_contest_id"
    t.index ["user_id"], name: "index_contests_users_on_user_id"
  end

  create_table "problems", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", null: false
    t.string "baseName", null: false
    t.string "color", default: "000000", null: false
    t.integer "timeLimit"
    t.string "descriptionFile"
    t.string "inputFile"
    t.string "outputFile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "codeforces_contest_id"
    t.string "codeforces_index"
    t.boolean "disabled", default: false
    t.string "delimiter", default: ""
  end

  create_table "solutions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.integer "problem_id", null: false
    t.string "solutionFile"
    t.integer "language", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contest_id"
    t.integer "status", default: 0
    t.integer "runtime"
    t.text "input"
    t.text "output"
    t.text "user_output"
    t.index ["contest_id"], name: "index_solutions_on_contest_id"
    t.index ["problem_id"], name: "index_solutions_on_problem_id"
    t.index ["user_id"], name: "index_solutions_on_user_id"
  end

  create_table "taggings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "handle"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "solutions", "contests"
  add_foreign_key "solutions", "problems"
  add_foreign_key "solutions", "users"
end
