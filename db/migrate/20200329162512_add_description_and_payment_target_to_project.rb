class AddDescriptionAndPaymentTargetToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :description, :string
    add_column :projects, :payment_target, :string
  end
end
