class ArticlesController < ApiController
  include ActiveModel::Serializers::JSON

  def index
    @articles = Article.where company: current_user.company

    @articles = @articles.joins(:articles_entries).where(articles_entries: {entry_id: params[:entry_id]}) if params[:entry_id].present?

    render json: @articles.to_json(include: :npk)
  end

  def create
    @article = Article.new params.require(:article).permit(:number, :name, :price, :unit, :description)
    @article.company = current_user.company

    @article.save!

    render json: @article
  end
end
