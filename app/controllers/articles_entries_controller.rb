class ArticlesEntriesController < ApiController
  def index
    @articles_entries = ArticlesEntry.where entry_id: params[:entry_id]

    render json: @articles_entries
  end

  def create
    @articles_entry = ArticlesEntry.create! params.permit(:article_id, :entry_id, :description, :amount, :discount)

    render json: @articles_entry
  end
end
