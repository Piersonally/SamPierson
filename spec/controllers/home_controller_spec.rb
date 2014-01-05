require 'spec_helper'

describe HomeController do

  describe 'GET index' do
    let!(:article1) { FactoryGirl.create :published_article, published_at: 1.day.ago }
    let!(:article2) { FactoryGirl.create :published_article }
    subject { get :index }
    before { subject }

    it "should display published articles" do
      expect(assigns(:index_page_data)[:articles]).to eq [article2, article1]
    end

    it "should display topics" do
      expect(
        assigns(:index_page_data)[:topics]
      ).to eq Topic.topics_with_article_counts
    end

    it { response.should render_template 'index' }
  end
end
