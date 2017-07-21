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

ActiveRecord::Schema.define(version: 20170721123026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ckeditor_assets", id: :serial, force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
  end

  create_table "contact_messages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_contact_messages_on_created_at"
    t.index ["updated_at"], name: "index_contact_messages_on_updated_at"
  end

  create_table "menus", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_menus_on_slug", unique: true
  end

  create_table "menus_pages", id: false, force: :cascade do |t|
    t.bigint "menu_id", null: false
    t.bigint "page_id", null: false
  end

  create_table "news", id: :serial, force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.datetime "time", null: false
    t.string "name", null: false
    t.text "excerpt"
    t.text "content"
    t.string "slug", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enabled", "time"], name: "index_news_on_enabled_and_time"
    t.index ["slug"], name: "index_news_on_slug", unique: true
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.string "name", null: false
    t.text "content"
    t.string "slug", null: false
    t.string "regexp"
    t.string "redirect"
    t.string "fullpath", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enabled", "lft"], name: "index_pages_on_enabled_and_lft"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "rails_admin_settings", id: :serial, force: :cascade do |t|
    t.boolean "enabled", default: true
    t.string "kind", default: "string", null: false
    t.string "ns", default: "main"
    t.string "key", null: false
    t.float "latitude"
    t.float "longitude"
    t.text "raw"
    t.string "label"
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_rails_admin_settings_on_key"
    t.index ["ns", "key"], name: "index_rails_admin_settings_on_ns_and_key", unique: true
  end

  create_table "seos", id: :serial, force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.integer "seoable_id"
    t.string "seoable_type"
    t.string "h1"
    t.string "title"
    t.text "keywords"
    t.text "description"
    t.string "og_title"
    t.string "robots"
    t.string "og_image_file_name"
    t.string "og_image_content_type"
    t.integer "og_image_file_size"
    t.datetime "og_image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seoable_id", "seoable_type"], name: "index_seos_on_seoable_id_and_seoable_type", unique: true
  end

  create_table "simple_captcha_data", id: :serial, force: :cascade do |t|
    t.string "key", limit: 40
    t.string "value", limit: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "idx_key"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "menus_pages", "menus", on_delete: :cascade
  add_foreign_key "menus_pages", "pages", on_delete: :cascade
end
