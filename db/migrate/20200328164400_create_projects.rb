class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.string :zip
      t.string :city

      t.timestamps
    end
  end
end
