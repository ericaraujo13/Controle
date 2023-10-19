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

ActiveRecord::Schema[7.0].define(version: 2023_10_19_014337) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "productions", force: :cascade do |t|
    t.string "description"
    t.decimal "quantity"
    t.date "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.index ["product_id"], name: "index_productions_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.date "date_time"
    t.decimal "quantity"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "storages", force: :cascade do |t|
    t.bigint "production_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["production_id"], name: "index_storages_on_production_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.date "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_transactions_on_product_id"
  end

  add_foreign_key "productions", "products"
  add_foreign_key "storages", "productions"
  add_foreign_key "transactions", "products"
end
