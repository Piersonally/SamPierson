module Concerns
  module SessionManagement

    def log_user_in(account)
      session[:account_id] = account.id
    end

    def log_out
      reset_session
    end

    def current_user
      @current_user ||= Account.find session[:account_id] if session[:account_id]
    end

    def user_logged_in?
      !!current_user
    end
  end
end
