class ArticlesController < ApiController
    def index
        @articles = Articel.where company: current_user.company
    
        render json: @articles
    end
end
