require 'spec_helper'

describe ArticleForm do
  let(:article) { FactoryGirl.create :article }
  let(:article_form) { ArticleForm.new article }
  subject { article_form }

  it_should_behave_like "ActiveModel"

  describe "#to_model" do
    subject { article_form.to_model }

    it "should return the underlying article" do
      should eq article
    end
  end
  
  describe "#update" do
    subject { article_form.update article_attributes }

    context "with invalid attributes" do
      let(:article_attributes) { { title: nil } }

      it "should not attempt to persist the article" do
        expect(article).not_to receive(:save)
        subject
        expect(article.reload.title).not_to eq 'new title'
      end

      it "should thereafter not be valid" do
        subject
        expect(article_form).not_to be_valid
      end
    end

    context "with valid attributes" do
      let(:article_attributes) { { title: "new title" } }

      it { expect { subject }.to change(article, :title).to('new title') }
      it { subject ; expect(article_form).to be_valid }
    end
  end

  describe "#save" do
    subject { article_form.save }

    context "when the article is invalid" do
      before { article.title = nil }

      it "should not persist the article" do
        expect(article_form).not_to receive(:persist!)
        subject
      end

      it "should return false" do
        expect(subject).to be_false
      end
    end

    context "when the article is valid" do
      before { article_form.article.title = "new title 2" }

      it "should persist the article" do
        subject
        expect(article.reload.title).to eq "new title 2"
      end

      it "should return true" do
        expect(subject).to be_true
      end
    end
  end
end
