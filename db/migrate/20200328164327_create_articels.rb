class CreateArticels < ActiveRecord::Migration[6.0]
  def change
    create_table :articels do |t|
      t.string :name
      t.references :npk, null: false, foreign_key: true
      t.decimal :price
      t.string :description
      t.string :unit
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
