class EntriesController < ApiController

  def show
    @entry = Entry.find params[:id]

    render json: @entry
  end

  def create
    permitted_params = params.require(:entry).permit(:title, :offer_id)
    permitted_params[:offer_id] = params[:offer_id]
    @entry = Entry.create! permitted_params

    render json: @entry
  end

  def update

  end

  def index
    @entries = Entry.where params.permit(:offer_id)

    render json: @entries
  end
end
