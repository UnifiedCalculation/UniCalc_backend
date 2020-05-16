class AllowNullNpkInArticle < ActiveRecord::Migration[6.0]
  def change
    change_column :articles, :npk_id, :integer, null: true, foreign_key: true
  end
end
