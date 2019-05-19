class AddHtmlOnFunds < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :html, :text
  end
end
