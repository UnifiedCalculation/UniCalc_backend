class EntriesController < ApiController

  def show
    @entry = Entry.find params[:id]

    render json: @entry
  end

  def create
    permitted_params = params.require(:entry).permit(:title)
    permitted_params[:form_id] = params[:form_id]
    @entry = Entry.create! permitted_params

    render json: @entry
  end

  def update

  end

  def index
    @entries = Entry.where params.permit(:form_id)

    render json: @entries
  end
end
