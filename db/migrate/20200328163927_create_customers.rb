class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :address
      t.string :zip
      t.string :city
      t.string :phone

      t.timestamps
    end
  end
end
