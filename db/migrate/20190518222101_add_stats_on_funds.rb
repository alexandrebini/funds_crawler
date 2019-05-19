class AddStatsOnFunds < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :return_y, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :return_12m, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :return_24m, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :return_36m, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :return_all, :decimal, precision: 8, scale: 2, index: true

    add_column :funds, :volatility_y, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :volatility_12m, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :volatility_24m, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :volatility_36m, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :volatility_all, :decimal, precision: 8, scale: 2, index: true

    add_column :funds, :sharpe_y, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :sharpe_12m, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :sharpe_24m, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :sharpe_36m, :decimal, precision: 8, scale: 2, index: true
    add_column :funds, :sharpe_all, :decimal, precision: 8, scale: 2, index: true
  end
end
