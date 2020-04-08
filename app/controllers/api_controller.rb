class ApiController < ActionController::API
    helper_method :current_user

    before_action :auth_user
  
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      else
        @current_user = nil
      end
    end
  
    def auth_user
      unless current_user && session[:user_id]
        redirect_to new_session_path
      end
    end
end