class CreateJoinTableArticelEntry < ActiveRecord::Migration[6.0]
  def change
    create_join_table :articels, :entries
  end
end
