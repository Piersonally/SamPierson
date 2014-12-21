require 'spec_helper'

feature "Sign Up", type: :feature, js: true do

  context "when signup is disabled" do
    before { allow_any_instance_of(AccountsController).to receive(:signup_enabled?) { false } }

    scenario "discovering signup is disabled" do
      visit signup_path
      expect(page).to have_content "Sign up is currently disabled"
      take_screenshot 'signup_disabled'
    end
  end

  context "when signup is enabled" do
    before { allow_any_instance_of(AccountsController).to receive(:signup_enabled?) { true } }

    scenario "unsuccessful signup" do
      visit signup_path
      within('h1') { expect(page).to have_content "Sign Up" }
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'First name', with: 'Englebert'
      fill_in 'Last name', with: 'Humperdink'
      fill_in 'account_password', with: 'password'
      fill_in 'Retype password', with: 'secret'
      take_screenshot 'signup_before'
      click_button 'Sign Up'
      within '.account_password_confirmation_group' do
        expect(page).to have_content "doesn't match Password"
      end
      take_screenshot 'signup_unsuccessful'
    end

    scenario "successful signup" do
      visit signup_path
      within('h1') { expect(page).to have_content "Sign Up" }
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'First name', with: 'Englebert'
      fill_in 'Last name', with: 'Humperdink'
      fill_in 'account_password', with: 'password'
      fill_in 'Retype password', with: 'password'
      click_button 'Sign Up'
      expect(page).to have_content "Thank you for signing up!"
      take_screenshot 'signup_successful'
    end
  end
end
