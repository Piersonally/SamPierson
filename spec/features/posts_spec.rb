require 'spec_helper'

feature "Posts", type: :feature, js: true do
  let(:author) { FactoryGirl.create :account }
  let!(:authors_post1) { FactoryGirl.create :post, author: author }
  let!(:authors_post2) { FactoryGirl.create :post, author: author }

  before { login_as author }

  scenario "displays the index" do
    click_link 'Posts'
    page.should have_content authors_post1.title
    page.should have_content authors_post2.title
    take_screenshot 'posts_index'
  end

  describe "creating a new post" do
    before do
      click_link 'Posts'
      click_link 'New Post'
    end

    scenario "with errors" do
      fill_in 'Title', with: "   "
      click_button 'Save'
      page.should have_content "can't be blank"
      take_screenshot 'posts_new_with_error'
    end

    scenario "successfully" do
      fill_in 'Title', with: "New Post Title"
      fill_in 'Body', with: "New Post Body"
      take_screenshot 'posts_new_before'
      click_button 'Save'
      page.should have_content 'Post was successfully created'
      page.should have_content "New Post Title"
      take_screenshot 'posts_new_after'
    end
  end

  scenario "edit an existing post" do
    click_link 'Posts'
    within "##{rails_dom_id authors_post1}" do
      click_link 'Edit'
    end
    take_screenshot 'posts_edit_before'
    fill_in 'Title', with: 'Updated Title'
    take_screenshot 'posts_edit_edited'
    click_button 'Save'
    page.should have_content 'Post was successfully updated'
    take_screenshot 'posts_edit_saved'
  end

  scenario "delete a post" do
    click_link 'Posts'
    take_screenshot 'posts_destroy_before'
    within "##{rails_dom_id authors_post1}" do
      click_link 'Destroy'
    end
    page.should have_content "was successfully destroyed"
    take_screenshot 'posts_destroy_after'
  end
end
