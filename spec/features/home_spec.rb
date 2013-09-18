require 'spec_helper'

describe 'Home page', type: :feature do
  it 'should display the home page' do
    visit root_path
    page.should have_content 'Home#index'
  end
end