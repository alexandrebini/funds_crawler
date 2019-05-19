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

ActiveRecord::Schema.define(version: 20_190_518_222_912) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'citext'
  enable_extension 'plpgsql'

  create_table 'funds', force: :cascade do |t|
    t.bigint 'tax_id', null: false
    t.citext 'name', null: false
    t.citext 'abbr_name'
    t.citext 'slug'
    t.citext 'type', null: false
    t.citext 'sub_type'
    t.citext 'benchmark'
    t.boolean 'qualified_investor_only'
    t.boolean 'exclusive'
    t.boolean 'opened'
    t.integer 'quotaholders'
    t.bigint 'patrimony'
    t.citext 'situation'
    t.text 'html'
    t.decimal 'return_y', precision: 8, scale: 2
    t.decimal 'return_12m', precision: 8, scale: 2
    t.decimal 'return_24m', precision: 8, scale: 2
    t.decimal 'return_36m', precision: 8, scale: 2
    t.decimal 'return_all', precision: 8, scale: 2
    t.decimal 'volatility_y', precision: 8, scale: 2
    t.decimal 'volatility_12m', precision: 8, scale: 2
    t.decimal 'volatility_24m', precision: 8, scale: 2
    t.decimal 'volatility_36m', precision: 8, scale: 2
    t.decimal 'volatility_all', precision: 8, scale: 2
    t.decimal 'sharpe_y', precision: 8, scale: 2
    t.decimal 'sharpe_12m', precision: 8, scale: 2
    t.decimal 'sharpe_24m', precision: 8, scale: 2
    t.decimal 'sharpe_36m', precision: 8, scale: 2
    t.decimal 'sharpe_all', precision: 8, scale: 2
    t.integer 'positive_months'
    t.integer 'benchmark_positive_months'
    t.integer 'negative_months'
    t.integer 'benchmark_negative_months'
    t.decimal 'higher_return', precision: 8, scale: 2
    t.decimal 'benchmark_higher_return', precision: 8, scale: 2
    t.decimal 'lower_return', precision: 8, scale: 2
    t.decimal 'benchmark_lower_return', precision: 8, scale: 2
    t.integer 'above_benchmark'
    t.integer 'below_benchmark'
    t.index ['exclusive'], name: 'index_funds_on_exclusive'
    t.index ['opened'], name: 'index_funds_on_opened'
    t.index ['qualified_investor_only'], name: 'index_funds_on_qualified_investor_only'
    t.index ['sub_type'], name: 'index_funds_on_sub_type'
    t.index ['tax_id'], name: 'index_funds_on_tax_id'
    t.index ['type'], name: 'index_funds_on_type'
  end
end
