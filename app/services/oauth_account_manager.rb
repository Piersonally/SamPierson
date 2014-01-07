class OauthAccountManager

  def initialize(provider)
    @provider = provider
  end

  def account_for(oauth_response)
    find_existing_oauth_account(oauth_response) ||
    create_oauth_account(oauth_response)
  end

  private

  def find_existing_oauth_account(auth)
    account = Account.where(oauth_provider: @provider, oauth_uid: auth.uid).first
    update_account_using_oauth_data(account, auth) if account
    account
  end

  def update_account_using_oauth_data(account, auth)
    account.update_attributes account_attrs(auth)
  end

  def create_oauth_account(auth)
    password = SecureRandom.base64
    attrs = account_attrs(auth).merge(
      password: password,
      password_confirmation: password
    )
    Account.create! attrs
  end

  def account_attrs(auth)
    {
      oauth_provider: @provider,
      oauth_uid: auth.uid,
      email: auth.email,
      first_name: auth.first_name,
      last_name:  auth.last_name,
      gravatar_id: auth.gravatar_id,
    }
  end
end
