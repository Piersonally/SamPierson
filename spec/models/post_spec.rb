require 'spec_helper'

describe Post do
  describe "database" do
    it { should have_db_index(:author_id) }
    it { should have_db_index(:published_at) }
    it { should have_foreign_key_for :accounts, column: 'author_id' }
  end

  describe "associations" do
    it { should belong_to(:author).class_name('Account') }
  end

  describe "scopes" do
    describe "published_at" do
      let!(:unpublished_post) { FactoryGirl.create :post }
      let!(:post1) { FactoryGirl.create :post, published_at: 2.days.ago }
      let!(:post2) { FactoryGirl.create :post, published_at: 1.day.ago }
      subject { Post.published }

      it "should return published posts in reverse chronoligical order" do
        subject.should eq [post2, post1]
      end
    end
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
