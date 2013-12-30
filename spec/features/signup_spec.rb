require 'spec_helper'

feature "Sign Up", type: :feature, js: true do

  # Signup is now disabled.

  #scenario "unsuccessful signup" do
  #  visit signup_path
  #  within('h1') { page.should have_content "Sign Up" }
  #  fill_in 'Email', with: 'foo@example.com'
  #  fill_in 'First name', with: 'Englebert'
  #  fill_in 'Last name', with: 'Humperdink'
  #  fill_in 'account_password', with: 'password'
  #  fill_in 'Retype password', with: 'secret'
  #  take_screenshot 'signup_before'
  #  click_button 'Sign Up'
  #  page.should have_content "Password confirmation doesn't match Password"
  #  take_screenshot 'signup_unsuccessful'
  #end
  #
  #scenario "successful signup" do
  #  visit signup_path
  #  within('h1') { page.should have_content "Sign Up" }
  #  fill_in 'Email', with: 'foo@example.com'
  #  fill_in 'First name', with: 'Englebert'
  #  fill_in 'Last name', with: 'Humperdink'
  #  fill_in 'account_password', with: 'password'
  #  fill_in 'Retype password', with: 'password'
  #  click_button 'Sign Up'
  #  page.should have_content "Thank you for signing up!"
  #  take_screenshot 'signup_successful'
  #end
end
