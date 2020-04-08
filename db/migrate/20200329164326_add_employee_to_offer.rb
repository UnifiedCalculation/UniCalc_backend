class AddEmployeeToOffer < ActiveRecord::Migration[6.0]
  def change
    add_reference :offers, :employee, null: true, foreign_key: true
  end
end
