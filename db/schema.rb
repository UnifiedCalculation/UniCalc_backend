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

ActiveRecord::Schema.define(version: 2020_05_16_104935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.bigint "npk_id", null: false
    t.decimal "price"
    t.string "description"
    t.string "unit"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number"
    t.index ["company_id"], name: "index_articles_on_company_id"
    t.index ["npk_id"], name: "index_articles_on_npk_id"
  end

  create_table "articles_entries", id: false, force: :cascade do |t|
    t.bigint "articel_id", null: false
    t.bigint "entry_id", null: false
    t.string "comment"
    t.integer "amount"
    t.decimal "discount"
    t.index ["articel_id", "entry_id"], name: "index_articles_entries_on_articel_id_and_entry_id"
    t.index ["entry_id", "articel_id"], name: "index_articles_entries_on_entry_id_and_articel_id"
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
    t.string "iban"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id"], name: "index_entries_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name"
    t.decimal "discount"
    t.bigint "employee_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_forms_on_employee_id"
    t.index ["project_id"], name: "index_forms_on_project_id"
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

  create_table "projects", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "company_id", null: false
    t.string "name"
    t.string "address"
    t.string "zip"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.string "payment_target"
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["customer_id"], name: "index_projects_on_customer_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id"
    t.index ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id"
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

  add_foreign_key "articles", "companies"
  add_foreign_key "articles", "npks"
  add_foreign_key "articles_entries", "articles", column: "articel_id"
  add_foreign_key "articles_entries", "entries"
  add_foreign_key "customers", "companies"
  add_foreign_key "customers", "users"
  add_foreign_key "employees", "companies"
  add_foreign_key "employees", "users"
  add_foreign_key "entries", "forms"
  add_foreign_key "forms", "employees"
  add_foreign_key "forms", "projects"
  add_foreign_key "npks", "npks"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "customers"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
end
