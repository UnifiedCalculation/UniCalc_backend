class RenameArticelToArtileInArticleEntries < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles_entries, :articel_id, :article_id
  end
end
