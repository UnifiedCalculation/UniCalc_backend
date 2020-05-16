class NpksController < ApiController
  def index
    @npks = Npk.all

    render json: @npks
  end
end
