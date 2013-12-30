require 'spec_helper'

feature 'Home page', type: :feature, js: true do
  scenario 'display the home page' do
    visit root_path
    page.should have_content 'Home#index'
    take_screenshot 'home_page'
  end
end
