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

ActiveRecord::Schema.define(version: 20160702193533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "color",      limit: 7
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contribution_factors", force: true do |t|
    t.decimal "factor"
    t.date    "initial_date"
  end

  create_table "contributions", force: true do |t|
    t.decimal  "amount"
    t.integer  "contributor_id"
    t.datetime "created_at"
    t.datetime "budget_date"
  end

  add_index "contributions", ["contributor_id"], name: "index_contributions_on_contributor_id", using: :btree

  create_table "contributors", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "expected_expenses", force: true do |t|
    t.decimal "value"
    t.string  "description"
    t.date    "initial_date"
    t.date    "final_date"
  end

  create_table "expenses", force: true do |t|
    t.string   "description"
    t.decimal  "value"
    t.datetime "budget_date"
    t.integer  "contributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "expected_expense_id"
    t.integer  "category_id"
  end

  add_index "expenses", ["category_id"], name: "index_expenses_on_category_id", using: :btree
  add_index "expenses", ["contributor_id"], name: "index_expenses_on_contributor_id", using: :btree

  create_table "periodic_expenses", force: true do |t|
    t.string   "description"
    t.decimal  "value"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "periodic_expenses", ["category_id"], name: "index_periodic_expenses_on_category_id", using: :btree

  create_table "revenues", force: true do |t|
    t.string   "description"
    t.decimal  "amount"
    t.datetime "budget_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "revenues", ["category_id"], name: "index_revenues_on_category_id", using: :btree

end
