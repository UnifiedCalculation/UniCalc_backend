class CustomersController < ApiController
  def index
    @customers = Customer.all

    @customer = @customers.where company: current_user.company if current_user.company.present?

    render json: @customers
  end
end
