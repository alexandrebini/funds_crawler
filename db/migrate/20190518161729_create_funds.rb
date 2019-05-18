class CreateFunds < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'citext'

    create_table :funds do |t|
      t.bigint :tax_id, null: false

      t.citext :name, null: false
      t.citext :abbr_name
      t.citext :slug

      t.citext :type, null: false, index: true
      t.citext :sub_type, index: true

      t.citext :benchmark

      t.boolean :qualified_investor_only, index: true
      t.boolean :exclusive, index: true
      t.boolean :opened, index: true

      t.integer :quotaholders
      t.bigint :patrimony

      t.citext :situation
    end

    add_index :funds, :tax_id, unique: true
  end
end
