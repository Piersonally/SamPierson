require 'spec_helper'

feature 'Home page', type: :feature, js: true do
  let!(:article1) { FactoryGirl.create :published_article }
  let!(:article2) { FactoryGirl.create :published_article }

  scenario 'it displays published articles' do
    visit root_path
    page.should have_content article1.title
    page.should have_content article2.title
    take_screenshot 'home_page'
  end
end
