class NotAuthorizedError < StandardError; end

class LoggedInController < ApplicationController
  before_filter :require_user_is_logged_in

  private

  def require_user_is_logged_in
    unless user_logged_in?
      redirect_to login_path, alert: 'You need to be logged in to do that.'
    end
  end

  def require_admin
    raise NotAuthorizedError unless current_user.is_admin?
  end

  rescue_from NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:error] = "Sorry, you're not allowed to do that."
    redirect_to request.headers["Referer"] || root_path
  end
end
