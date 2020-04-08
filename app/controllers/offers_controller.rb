class OffersController < ApiController
    def index
        @offers = Offer.where project_id: params[:project_id]

        render json: @offers
    end

    def show
        @offer = Offer.find params[:id]

        render json: @offer.to_json(include: {entries: {include: :articles}})
    end

    def create
        data = params.permit(:name, :project_id)
        
        @offer = Offer.new data
        
        if @offer.save!
          render json: @offer
        else
          render json: {response: 'Record invalid'}, status: 400
        end
    end

    def update
        byebug
    end

end
