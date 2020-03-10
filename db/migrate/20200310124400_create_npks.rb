class CreateNpks < ActiveRecord::Migration[6.0]
  def change
    create_table :npks do |t|
      t.references :npk, null: true, foreign_key: true
      t.string :name
      t.integer :number

      t.timestamps
    end
    add_index :npks, :number
  end
end
