class EmployeesController < ApiController
  include ActiveModel::Serializers::JSON

  def index
    @employees = Employee.select(:id, :user_id, :company_id, :firstname, :lastname, :email).joins(:user).all

    result = []
    @employees.each do |employee|
      user = employee.user
      employee = employee.attributes
      employee[:roles] = user.roles.map(&:name)

      result << employee
    end

    render json: result
  end

  def show
    employee = User.select(:id, :user_id, :company_id, :firstname, :lastname, :email).joins(:employee).find params[:id]

    user = employee.user
    employee = employee.attributes
    employee[:roles] = user.roles.map(&:name)

    render json: employee
  end

  def create
    user = User.new params.permit(:email, :firstname, :lastname)
    user.password = user.password_confirmation = (0...16).map { ('a'..'z').to_a[rand(26)] }.join
    user.save!

    params[:roles].each do |role_str|
      user.roles << Role.find_by(name: role_str)
    end

    employee = Employee.create! user: user, company: current_user.company

    render json: employee
  end

  def update
    employee = Employee.find params[:id]
    user = employee.user

    user.update! params.permit(:firstname, :lastname, :email)

    user.roles.destroy_all

    params[:roles].each do |role_str|
      user.roles << Role.find_by(name: role_str)
    end

    render json: employee
  end
end
