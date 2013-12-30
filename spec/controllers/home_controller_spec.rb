require 'spec_helper'

describe HomeController do

  describe 'GET index' do
    let!(:post1) { FactoryGirl.create :published_post, published_at: 1.day.ago }
    let!(:post2) { FactoryGirl.create :published_post }
    subject { get :index }
    before { subject }

    it "should display published posts" do
      assigns(:posts).should == [post2, post1]
    end

    it { response.should render_template 'index' }
  end
end
