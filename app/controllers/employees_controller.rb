class EmployeesController < ApiController
  def index
    @employee = Employee.select(:id, :user_id, :company_id, :firstname, :lastname, :email).joins(:user).all

    render json: @employee
  end

  def show
    employee = Employee.select(:id, :user_id, :company_id, :firstname, :lastname, :email).joins(:user).find params[:id]

    render json: employee
  end
end
