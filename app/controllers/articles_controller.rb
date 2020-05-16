class ArticlesController < ApiController
  def index
    @articles = Article.where company: current_user.company

    render json: @articles
  end

  def create
    @article = Article.create! params.require(:article).permit(:number, :name, :price, :unit, :description)

    render json: @article
  end
end
