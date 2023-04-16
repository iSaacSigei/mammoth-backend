class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    # app/controllers/application_controller.rb
    # before_action :require_login
  
    private
    
    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to login_path # or redirect_to root_path if you prefer
      end
    end
    
    def logged_in?
      current_user || current_admin
    end
    
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def current_admin
        @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
    end
      
end
  

