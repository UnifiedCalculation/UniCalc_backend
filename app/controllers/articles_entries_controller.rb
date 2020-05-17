class ArticlesEntriesController < ApiController
  def index
    @articles_entries = ArticlesEntry.select(:article_id, :entry_id, :name, :amount, :discount, :price, :description, :unit).joins(:article).where entry_id: params[:entry_id]

    render json: @articles_entries
  end

  def create
    @articles_entry = ArticlesEntry.create! params.permit(:article_id, :entry_id, :description, :amount, :discount)

    render json: @articles_entry
  end

  def update
    article_entry = ArticlesEntry.find_by entry_id: params[:entry_id], article_id: params[:id]

    article_entry.update params.require(:article_entry).permit(:amount, :description, :discount)

    render json: article_entry
  end
end
