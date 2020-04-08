class CompaniesController < ApiController
  include ActiveModel::Serializers::JSON

  def customers
    @customers = Customer.where company: current_user.company
    # TODO: Remove password_digest
    render json: @customers.to_json(include: :user)
  end

  def projects
    @projects = Project.where company: current_user.company

    render json: @projects
  end
end
