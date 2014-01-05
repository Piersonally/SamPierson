require 'spec_helper'

feature "Articles", type: :feature, js: true do
  let(:author) { FactoryGirl.create :account }
  let!(:authors_article1) { FactoryGirl.create :article, author: author }
  let!(:authors_article2) { FactoryGirl.create :article, author: author }

  before { login_as author }

  scenario "displays the index" do
    click_link 'Articles'
    page.should have_content authors_article1.title
    page.should have_content authors_article2.title
    take_screenshot 'articles_index'
  end

  describe "creating a new article" do
    before do
      click_link 'Articles'
      click_link 'New Article'
    end

    scenario "with errors" do
      fill_in 'Title', with: "   "
      click_button 'Save'
      page.should have_content "can't be blank"
      take_screenshot 'articles_new_with_error'
    end

    scenario "successfully" do
      fill_in 'Title', with: "New Article Title"
      fill_in 'Body', with: "New Article Body"
      fill_in 'Tags', with: "tag1 tag2"
      take_screenshot 'articles_new_before'
      click_button 'Save'
      page.should have_content 'Article was successfully created'
      page.should have_content "New Article Title"
      page.should have_content "New Article Body"
      page.should have_content "tag1, tag2"
      take_screenshot 'articles_new_after'
    end
  end

  scenario "edit an existing article" do
    click_link 'Articles'
    within "##{rails_dom_id authors_article1}" do
      click_link 'Edit'
    end
    take_screenshot 'articles_edit_before'
    fill_in 'Title', with: 'Updated Title'
    take_screenshot 'articles_edit_edited'
    click_button 'Save'
    page.should have_content 'Article was successfully updated'
    take_screenshot 'articles_edit_saved'
  end

  scenario "delete a article" do
    click_link 'Articles'
    take_screenshot 'articles_destroy_before'
    within "##{rails_dom_id authors_article1}" do
      click_link 'Destroy'
    end
    page.should have_content "was successfully destroyed"
    take_screenshot 'articles_destroy_after'
  end
end
