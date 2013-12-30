class LoggedInController < ApplicationController
  before_filter :require_user_is_logged_in

  private

  def require_user_is_logged_in
    unless user_logged_in?
      redirect_to login_path, alert: 'You need to be logged in to do that.'
    end
  end
end
