class EmployeesController < ApiController
  def index
    @employee = Employee.all

    render json: @employee
  end
end
