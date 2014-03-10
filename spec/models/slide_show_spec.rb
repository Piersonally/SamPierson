require 'spec_helper'

describe SlideShow do
  describe "mixins" do
    it_should_behave_like "a model that slugs column", :title
  end

  describe "database" do
    it { should have_db_index(:author_id) }
    it { should have_db_index(:slug).unique(true) }
    it { should have_foreign_key_for :accounts, column: 'author_id' }
  end

  describe "associations" do
    it { should belong_to(:author).class_name('Account') }
  end

  describe "attributes"

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :author_id }
  end

  describe "authorization"

  describe "lifecycle"

  describe "class methods"

  describe "instance methods"
end
