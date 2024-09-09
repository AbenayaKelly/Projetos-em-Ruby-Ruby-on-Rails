# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_22_223124) do
  create_table "eventos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.date "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inscricaos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "evento_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evento_id"], name: "index_inscricaos_on_evento_id"
    t.index ["user_id"], name: "index_inscricaos_on_user_id"
  end

  create_table "insticaos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "evento_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evento_id"], name: "index_insticaos_on_evento_id"
    t.index ["user_id"], name: "index_insticaos_on_user_id"
  end

  create_table "participantes", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.integer "evento_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evento_id"], name: "index_participantes_on_evento_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.string "nome"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "inscricaos", "eventos"
  add_foreign_key "inscricaos", "users"
  add_foreign_key "insticaos", "eventos"
  add_foreign_key "insticaos", "users"
  add_foreign_key "participantes", "eventos"
end
