class AddBenchmarksOnFunds < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :positive_months, :integer, index: true
    add_column :funds, :benchmark_positive_months, :integer, index: true
    add_column :funds, :negative_months, :integer, index: true
    add_column :funds, :benchmark_negative_months, :integer, index: true

    add_column :funds, :higher_return, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :benchmark_higher_return, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :lower_return, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :benchmark_lower_return, :decimal, precision: 8, scale: 2, index: true

    add_column :funds, :above_benchmark, :integer, index: true
    add_column :funds, :below_benchmark, :integer, index: true
  end
end
