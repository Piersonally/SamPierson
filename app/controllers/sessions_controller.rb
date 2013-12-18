class SessionsController < ApplicationController

  def new
  end

  def create
    account = Account.find_by_email params[:email]
    if account && account.authenticate(params[:password])
      log_user_in account
      redirect_to root_url, notice: "You logged in successfully."
    else
      flash.now.alert = "Email or password is invalid."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: "You are now logged out."
  end
end
