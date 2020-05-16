class ArticlesController < ApiController
  def index
    @articles = Article.where company: current_user.company

    render json: @articles
  end

  def create
    @article = Article.new params.require(:article).permit(:number, :name, :price, :unit, :description)
    @article.company = current_user.company

    @article.save!

    render json: @article
  end
end
