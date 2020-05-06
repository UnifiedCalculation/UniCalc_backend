class UsersController < ApplicationController
  skip_before_action :auth_user, only: [:new, :create]

  def new

  end

  def create
    company = Company.create! name: params[:company_name],
                              phone: params[:phone_number],
                              mail: params[:email],
                              city: params[:city],
                              zip: params[:zip],
                              address: params[:address],
                              url: params[:webpage],
                              iban: params[:iban]

    user = User.create! firstname: params[:owner_firstname],
                        lastname: params[:owner_surname],
                        email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation]

    Employee.create! user: user,
                     company: company,
                     role: "admin"


    redirect_to new_session_path
  end

  def username
    render json: current_user.to_json(only: [:firstname, :lastname])
  end
end
