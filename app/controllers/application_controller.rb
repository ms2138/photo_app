class ApplicationController < ActionController::Base
    before_action :authenticate_user!    
    before_action :configure_permitted_parameters, if: :devise_controller?

    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :website, :bio])
    end

    private
    
    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end

    def user_not_authorized
        redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
end
