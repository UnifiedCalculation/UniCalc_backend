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
    article_entry = ArticlesEntry.where(entry_id: params[:entry_id], article_id: params[:article_id]).update_all(amount: params[:articles_entry][:amount], description: params[:articles_entry][:description], discount: params[:articles_entry][:discount])

    render json: article_entry
  end
end
