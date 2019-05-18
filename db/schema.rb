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

ActiveRecord::Schema.define(version: 2019_05_18_161729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "funds", force: :cascade do |t|
    t.bigint "tax_id", null: false
    t.string "name", null: false
    t.string "abbr_name"
    t.string "slug"
    t.string "type", null: false
    t.string "sub_type"
    t.string "benchmark"
    t.boolean "qualified_investor_only"
    t.boolean "exclusive"
    t.boolean "opened"
    t.integer "quotaholders"
    t.bigint "patrimony"
    t.string "situation"
    t.index ["exclusive"], name: "index_funds_on_exclusive"
    t.index ["opened"], name: "index_funds_on_opened"
    t.index ["qualified_investor_only"], name: "index_funds_on_qualified_investor_only"
    t.index ["sub_type"], name: "index_funds_on_sub_type"
    t.index ["tax_id"], name: "index_funds_on_tax_id"
    t.index ["type"], name: "index_funds_on_type"
  end

end
