class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name
      t.decimal :discount
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
