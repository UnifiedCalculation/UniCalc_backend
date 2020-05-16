class RenameCommentToDescriptionInArticlesEntries < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles_entries, :comment, :description
  end
end
