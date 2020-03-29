class CreateJoinTableArticelEntry < ActiveRecord::Migration[6.0]
  def change
    create_join_table :articels, :entries, column_options: { null: false, foreign_key: true } do |t|
      t.index [:articel_id, :entry_id]
      t.index [:entry_id, :articel_id]
    end
  end
end
