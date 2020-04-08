class RemoveDiscountFromEntries < ActiveRecord::Migration[6.0]
  def change

    remove_column :entries, :discount, :decimal
  end
end
