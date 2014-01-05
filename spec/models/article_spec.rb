require 'spec_helper'

describe Article do

  describe "mixins" do
    it_should_behave_like "a model that slugs column", :title
  end

  describe "database" do
    it { should have_db_index(:author_id) }
    it { should have_db_index(:published_at) }
    it { should have_foreign_key_for :accounts, column: 'author_id' }
  end

  describe "associations" do
    it { should belong_to(:author).class_name('Account') }
    # it { should have_and_belong_to_many :topics } # Broken matcher with Rails 4.1
  end

  describe "scopes" do
    describe "visible" do
      let!(:unpublished_article) { FactoryGirl.create :article }
      let!(:visible_article1) { FactoryGirl.create :published_article, published_at: 2.days.ago }
      let!(:visible_article2) { FactoryGirl.create :published_article, published_at: 1.day.ago }
      let!(:invisible_article) { FactoryGirl.create :published_article, visible: false }
      subject { Article.visible }

      it "should return visible articles in reverse chronoligical order of publishing date" do
        subject.should eq [visible_article2,  visible_article1]
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

    describe "publish!" do
      let(:article) { FactoryGirl.create :article }
      subject { article.publish! }

      it "should update published_at" do
        expect { subject }.to change(article, :published_at).from(nil)
      end
      it "should set visible to true" do
        expect { subject }.to change(article, :visible).from(false).to(true)
      end
    end

    describe "#synopsis_covers_everthing?" do
      subject { article.synopsis_covers_everything? }

      context "for a single paragraph article" do
        let(:article) {
          FactoryGirl.create :article, body: "Single. Paragraph."
        }
        it { should be_true }
      end

      context "for a multi paragraph article" do
        let(:article) {
          FactoryGirl.create :article, body: "Multiple.\r\n\r\nParagraphs."
        }
        it { should be_false }
      end
    end
  end
end
