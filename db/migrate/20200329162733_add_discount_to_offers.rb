class AddDiscountToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :discount, :decimal
  end
end
