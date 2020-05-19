class AddOfferReferenceToContract < ActiveRecord::Migration[6.0]
  def change
    add_reference :forms, :copied_from, foreign_key: { to_table: :forms }, null: true
  end
end
