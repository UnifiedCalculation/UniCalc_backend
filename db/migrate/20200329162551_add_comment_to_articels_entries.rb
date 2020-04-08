class AddCommentToArticelsEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :articels_entries, :comment, :string
  end
end
