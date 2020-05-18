class CustomersController < ApiController
  def index
    @customers = Customer.select(:id, :user_id, :company_id, :firstname, :lastname, :email).joins(:user).all

    @customers = @customers.where company: current_user.company if current_user.company.present?

    render json: @customers
  end
end
