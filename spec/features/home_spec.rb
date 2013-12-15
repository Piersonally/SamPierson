require 'spec_helper'

describe 'Home page', type: :feature, js: true do
  it 'should display the home page' do
    visit root_path
    page.should have_content 'Home#index'
    take_screenshot 'home_page'
  end
end