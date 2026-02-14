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

ActiveRecord::Schema[8.1].define(version: 2026_02_14_025314) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "components", force: :cascade do |t|
    t.string "brand"
    t.bigint "computer_id", null: false
    t.datetime "created_at", null: false
    t.string "name"
    t.string "serial_num"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["computer_id"], name: "index_components_on_computer_id"
  end

  create_table "computers", force: :cascade do |t|
    t.string "brand"
    t.datetime "created_at", null: false
    t.bigint "laboratory_id", null: false
    t.string "serial_num"
    t.string "status"
    t.integer "team_num"
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_computers_on_laboratory_id"
  end

  create_table "laboratories", force: :cascade do |t|
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.string "lab_code"
    t.string "location"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "professors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.string "professor_code"
    t.string "program"
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "computer_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "laboratory_id", null: false
    t.bigint "professor_id", null: false
    t.string "report_code"
    t.datetime "report_date"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["computer_id"], name: "index_reports_on_computer_id"
    t.index ["laboratory_id"], name: "index_reports_on_laboratory_id"
    t.index ["professor_id"], name: "index_reports_on_professor_id"
  end

  add_foreign_key "components", "computers"
  add_foreign_key "computers", "laboratories"
  add_foreign_key "reports", "computers"
  add_foreign_key "reports", "laboratories"
  add_foreign_key "reports", "professors"
end
