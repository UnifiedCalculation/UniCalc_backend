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

ActiveRecord::Schema.define(version: 2020_03_29_112812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articels", force: :cascade do |t|
    t.string "name"
    t.bigint "npk_id", null: false
    t.decimal "price"
    t.string "description"
    t.string "unit"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_articels_on_company_id"
    t.index ["npk_id"], name: "index_articels_on_npk_id"
  end

  create_table "articels_entries", id: false, force: :cascade do |t|
    t.bigint "articel_id", null: false
    t.bigint "entry_id", null: false
    t.index ["articel_id", "entry_id"], name: "index_articels_entries_on_articel_id_and_entry_id"
    t.index ["entry_id", "articel_id"], name: "index_articels_entries_on_entry_id_and_articel_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "phone"
    t.string "mail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.string "address"
    t.string "zip"
    t.string "city"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_customers_on_company_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "offer_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["offer_id"], name: "index_entries_on_offer_id"
  end

  create_table "npks", force: :cascade do |t|
    t.bigint "npk_id"
    t.string "name"
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["npk_id"], name: "index_npks_on_npk_id"
    t.index ["number"], name: "index_npks_on_number"
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_offers_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "company_id", null: false
    t.string "name"
    t.string "address"
    t.string "zip"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["customer_id"], name: "index_projects_on_customer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "firstname"
    t.string "lastname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "articels", "companies"
  add_foreign_key "articels", "npks"
  add_foreign_key "articels_entries", "articels"
  add_foreign_key "articels_entries", "entries"
  add_foreign_key "customers", "companies"
  add_foreign_key "customers", "users"
  add_foreign_key "employees", "companies"
  add_foreign_key "employees", "users"
  add_foreign_key "entries", "offers"
  add_foreign_key "npks", "npks"
  add_foreign_key "offers", "projects"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "customers"
end
