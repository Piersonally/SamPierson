module Concerns
  module SessionManagement
    def current_user
      @current_user ||= Account.find session[:account_id] if session[:account_id]
    end

    def user_logged_in?
      !!current_user
    end
  end
end