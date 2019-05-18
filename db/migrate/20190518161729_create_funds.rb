class CreateFunds < ActiveRecord::Migration[5.2]
  def change
    create_table :funds do |t|
      t.bigint :tax_id, null: false

      t.string :name, null: false
      t.string :abbr_name
      t.string :slug

      t.string :type, null: false, index: true
      t.string :sub_type, index: true

      t.string :benchmark

      t.boolean :qualified_investor_only, index: true
      t.boolean :exclusive, index: true
      t.boolean :opened, index: true

      t.integer :quotaholders
      t.bigint :patrimony

      t.string :situation
    end

    add_index :funds, :tax_id, unique: true
  end
end
