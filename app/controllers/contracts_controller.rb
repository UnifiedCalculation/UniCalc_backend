class ContractsController < ApiController
  def index
    if params[:project_id].present?
      @offers = Contract.where project_id: params[:project_id]
    else
      @offers = Contract.where employee: current_user.employee
    end

    render json: @offers
  end

  def show
    @offer = Contract.find params[:id]

    render json: @offer
  end

  def create
    data = params.permit(:name, :project_id)
    
    @offer = Contract.new data
    
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
