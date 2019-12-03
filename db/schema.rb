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

ActiveRecord::Schema.define(version: 2019_12_03_114936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balances", force: :cascade do |t|
    t.integer "income", default: 0
    t.integer "planned_savings", default: 0
    t.integer "savings", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "created_by"
    t.date "balance_date"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "created_by"
    t.integer "category_savings", default: 0
    t.bigint "cycle_id"
    t.integer "category_planned_savings", default: 0
    t.index ["cycle_id"], name: "index_categories_on_cycle_id"
  end

  create_table "cycles", force: :cascade do |t|
    t.integer "planned_value", default: 0
    t.integer "created_by"
    t.bigint "balance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_day"
    t.date "end_day"
    t.integer "duration", default: 30
    t.integer "cycle_value", default: 0
    t.index ["balance_id"], name: "index_cycles_on_balance_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "value", default: 0
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by"
    t.date "expense_day"
    t.index ["category_id"], name: "index_expenses_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "whole_savings", default: 0
  end

  add_foreign_key "expenses", "categories"
end
