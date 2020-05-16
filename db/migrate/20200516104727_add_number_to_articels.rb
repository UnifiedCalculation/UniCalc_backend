class AddNumberToArticels < ActiveRecord::Migration[6.0]
  def change
    add_column :articels, :number, :integer
  end
end
