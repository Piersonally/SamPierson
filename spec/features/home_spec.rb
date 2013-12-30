require 'spec_helper'

feature 'Home page', type: :feature, js: true do
  let!(:post1) { FactoryGirl.create :published_post }
  let!(:post2) { FactoryGirl.create :published_post }

  scenario 'it displays published posts' do
    visit root_path
    page.should have_content post1.title
    page.should have_content post2.title
    take_screenshot 'home_page'
  end
end
