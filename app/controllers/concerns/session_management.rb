module Concerns
  module SessionManagement

    def log_user_in(account)
      session[:account_id] = account.id
    end

    def log_out
      reset_session
    end

    def current_user
      account_id = session[:account_id]
      @current_user ||= Account.find account_id if account_id
    end

    def user_logged_in?
      !!current_user
    end
  end
end
