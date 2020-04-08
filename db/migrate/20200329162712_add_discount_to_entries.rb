class AddDiscountToEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :discount, :decimal
  end
end
