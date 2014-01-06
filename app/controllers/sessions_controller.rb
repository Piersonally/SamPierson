class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [ :create_oauth ]

  def new
  end

  def create
    account = Account.find_by_email params[:login][:email]
    if account && account.authenticate(params[:login][:password])
      log_user_in account
      redirect_to root_url, notice: "You logged in successfully."
    else
      flash.now.alert = "Email or password is invalid."
      render "new"
    end
  end

  def create_oauth
    oauth_response = OauthResponse.new request.env["omniauth.auth"]
    oauth_account_manager ||= OauthAccountManager.new params[:provider]
    account = oauth_account_manager.account_for oauth_response
    log_user_in account
    redirect_to root_url, notice: "You logged in successfully."
  end

  def destroy
    log_out
    redirect_to root_path, notice: "You are now logged out."
  end
end
