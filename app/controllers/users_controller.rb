class UsersController < ApiController
  def username
    render json: current_user.to_json(only: [:firstname, :lastname])
  end
end
