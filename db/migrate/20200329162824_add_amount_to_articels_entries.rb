class AddAmountToArticelsEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :articels_entries, :amount, :integer
  end
end
