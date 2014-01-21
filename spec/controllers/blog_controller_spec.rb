require 'spec_helper'

describe BlogController do

  describe "GET show" do
    let!(:article1) { FactoryGirl.create :published_article, published_at: 1.day.ago }
    let!(:article2) { FactoryGirl.create :published_article }
    subject { get :show }
    before { subject }

    it "should display published articles" do
      expect(assigns(:blog_data)[:articles]).to eq [article2, article1]
    end

    it "should display topics" do
      expect(
        assigns(:blog_data)[:topics]
      ).to eq Topic.topics_with_article_counts
    end

    it { response.should render_template "show" }
  end

  describe "GET rss" do
    subject { get :rss, format: 'xml' }

    describe "if there are more than 10 published articesl" do
      before {
        12.times { FactoryGirl.create :published_article }
      }

      it "should set @articles to the 10 most recent" do
        subject
        expect(assigns(:articles).size).to eq 10
      end

      it { expect(subject).to render_template 'rss' }
    end
  end
end
