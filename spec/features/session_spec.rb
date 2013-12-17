require 'spec_helper'

describe "Log In", type: :feature, js: true do
  let(:account) {
    FactoryGirl.create :account, first_name: 'Fred', last_name: 'Bloggs'
  }

  it "unsuccessful login" do
    visit login_path
    within('h1') { expect(page).to have_content "Log In" }
    fill_in 'Email', with: account.email
    fill_in 'Password', with: 'wrong password'
    take_screenshot 'login_before'
    click_button 'Log In'
    expect(page).to have_content "Email or password is invalid."
    take_screenshot 'login_unsuccessful'
  end

  it "successful login" do
    visit login_path
    within('h1') { expect(page).to have_content "Log In" }
    fill_in 'Email', with: account.email
    fill_in 'Password', with: 'secret'
    click_button 'Log In'
    expect(page).to have_content "You logged in successfully."
    take_screenshot 'login_successful'
  end

  it "logout" do
    login_as account
    click_link account.full_name
    click_link 'Log Out'
    expect(page).to have_content "You are now logged out."
  end
end
