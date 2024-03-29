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

ActiveRecord::Schema.define(version: 20170927123512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "link_infos", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.integer "vendor_location_id"
    t.string "token"
    t.boolean "auto_print", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "order_number"
    t.text "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "order_date"
    t.boolean "parsed", default: false
    t.text "meals"
    t.string "delivery_instructions"
    t.decimal "tip"
    t.decimal "total"
    t.text "address"
    t.decimal "product_total"
    t.decimal "sales_tax"
    t.decimal "delivery_fee"
    t.boolean "failed_parsing", default: false
    t.string "account"
    t.index ["order_number"], name: "index_orders_on_order_number"
  end

end
