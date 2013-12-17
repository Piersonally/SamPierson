module FeatureHelpers
  def login_as(account)
    visit login_path
    fill_in 'Email', with: account.email
    fill_in 'Password', with: 'secret'
    click_button 'Log In'
    expect(page).to have_content "You logged in successfully."
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
