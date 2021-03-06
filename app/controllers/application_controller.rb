# ApplicationController
# Please note the existence of LoggedInController, from which most controllers
# should descend.

class ApplicationController < ActionController::Base
  include Concerns::SessionManagement
  helper_method :current_user, :user_logged_in?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
