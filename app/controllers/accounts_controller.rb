class AccountsController < ApplicationController
  before_filter :redirect_unless_signup_is_enabled

  def new
    @account = Account.new
  end

  def create
    if create_account
      log_user_in @account
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      render 'new'
    end
  end

  private

  def redirect_unless_signup_is_enabled
    unless signup_enabled?
      redirect_to root_path, alert: 'Sign up is currently disabled.'
    end
  end

  def signup_enabled?
    false
  end

  def account_params
    params.require(:account).permit(
      :email, :first_name, :last_name, :password, :password_confirmation
    )
  end

  def create_account
    @account = Account.new account_params
    @account.save
  end
end
