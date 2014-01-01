require 'spec_helper'

describe Article do
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
      let!(:unpublished_article) { FactoryGirl.create :article }
      let!(:article1) { FactoryGirl.create :article, published_at: 2.days.ago }
      let!(:article2) { FactoryGirl.create :article, published_at: 1.day.ago }
      subject { Article.published }

      it "should return published articles in reverse chronoligical order" do
        subject.should eq [article2, article1]
      end
    end
  end

  describe "attributes"

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :author_id }
    it { should validate_presence_of :slug }
    it { should validate_uniqueness_of :slug }
  end

  describe "authorization"

  describe "lifecycle" do
    let(:author) { FactoryGirl.create :account }

    it "should set a slug when created" do
      article = Article.new title: "A Title", author: author
      article.save!
      expect(article.slug).to eq 'a-title'
    end

    it "should not change an exisiting slug on save" do
      article = FactoryGirl.create :article, title: 'Title One'
      expect(article.slug).to eq 'title-one'
      article.update_attributes! title: 'Title Two'
      expect(article.slug).to eq 'title-one'
    end
  end

  describe "class methods"

  describe "instance methods" do
    describe "published?" do
      subject { article.published? }

      context "for an unpublished article" do
        let(:article) { FactoryGirl.create :article }

        it { should be_false }
      end

      context "for a published article" do
        let(:article) { FactoryGirl.create :published_article }

        it { should be_true }
      end
    end
  end
end
