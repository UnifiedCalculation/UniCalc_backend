class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.references :form, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
