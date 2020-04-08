class AddDiscountToArticelsEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :articels_entries, :discount, :decimal
  end
end
