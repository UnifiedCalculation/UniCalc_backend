class CompaniesController < ApiController
  include ActiveModel::Serializers::JSON

  def customers
    @customers = Customer.where company: current_user.company
    render json: @customers.to_json(include: {user: {only: [:firstname, :lastname, :email]}})
  end

  def projects
    @projects = Project.where company: current_user.company

    render json: @projects
  end
end
