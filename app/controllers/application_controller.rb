class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_currentuser

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :acountid, :gender, :icon, :introduction])
  end
  def set_currentuser
    if user_signed_in?
      @currentuser  = User.find_by(id: current_user.id)
    end
  end
end