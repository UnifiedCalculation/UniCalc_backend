class RenameArticelToArticle < ActiveRecord::Migration[6.0]
  def change
    rename_table :articels, :articles
    rename_table :articels_entries, :articles_entries
  end
end
