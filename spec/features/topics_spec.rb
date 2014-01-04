require 'spec_helper'

feature "Topics", type: :feature, js: true do
  let(:user) { FactoryGirl.create :account }
  let!(:topic) { FactoryGirl.create :topic }

  before { login_as user }

  scenario "displays the index" do
    click_link 'Topics'
    page.should have_content topic.name
    take_screenshot 'topics_index'
  end

  describe "creating a new topic" do
    before do
      click_link 'Topics'
      click_link 'New Topic'
    end

    scenario "with errors" do
      fill_in 'Name', with: "   "
      click_button 'Save'
      page.should have_content "can't be blank"
      take_screenshot 'topics_new_with_error'
    end

    scenario "successfully" do
      fill_in 'Name', with: "new-topic"
      take_screenshot 'topics_new_before'
      click_button 'Save'
      page.should have_content 'Topic was successfully created'
      page.should have_content "new-topic"
      take_screenshot 'topics_new_after'
    end
  end

  scenario "edit an existing topic" do
    click_link 'Topics'
    within "##{rails_dom_id topic}" do
      click_link 'Edit'
    end
    take_screenshot 'topics_edit_before'
    fill_in 'Name', with: 'updated-name'
    take_screenshot 'topics_edit_edited'
    click_button 'Save'
    page.should have_content 'Topic was successfully updated'
    take_screenshot 'topics_edit_saved'
  end

  scenario "delete a topic" do
    click_link 'Topics'
    take_screenshot 'topics_destroy_before'
    within "##{rails_dom_id topic}" do
      click_link 'Destroy'
    end
    page.should have_content "was successfully destroyed"
    take_screenshot 'topics_destroy_after'
  end
end
