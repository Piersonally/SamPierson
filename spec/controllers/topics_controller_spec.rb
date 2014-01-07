require 'spec_helper'

describe TopicsController do
  let(:user) { FactoryGirl.create :admin_account }
  let!(:topic) { FactoryGirl.create :topic }
  
  let(:valid_attributes) { { name: "computers" } }

  # TODO it should require user to be logged in to access ALL actions
  
  context "while not logged in" do
    describe "GET index" do
      subject { get :index }
      
      it { expect(subject).to redirect_to login_path }
      it { subject; expect(flash[:alert]).to be_present }
    end
  end
  
  context "while logged in" do
    before { session[:account_id] = user.id }
    
    describe "GET index" do
      before { get :index }

      it { expect(assigns(:topics)).to eq [topic] }
      it { expect(response).to render_template 'index' }
    end
  
    describe "GET show" do
      before { get :show, id: topic.to_param }

      it { expect(assigns(:topic)).to eq topic }
      it { expect(response).to render_template 'show' }
    end
  
    describe "GET new" do
      before { get :new }

      it { expect(assigns(:topic)).to be_a_new Topic }
      it { expect(response).to render_template 'new' }
    end
  
    describe "GET edit" do
      before { get :edit, id: topic.to_param }

      it { expect(assigns(:topic)).to eq topic }
      it { expect(response).to render_template 'edit' }
    end
  
    describe "POST create" do
      subject { post :create, topic: topic_attributes }

      describe "with valid params" do
        let(:name) { 'new-topic' }
        let(:topic_attributes) { { name: name } }
        let(:created_topic) { Topic.last }

        it "creates a new Topic" do
          expect {
            subject
          }.to change(Topic, :count).by(1)
        end

        describe "and" do
          before { subject }

          it { expect(assigns :topic).to eq created_topic }
          it { expect(created_topic.name).to eq name }
          it { should redirect_to created_topic }
          it { expect(flash[:notice]).to be_present }
        end
      end
  
      describe "with invalid params" do
        let(:topic_attributes) { { name: nil } }
        before { subject }

        it { expect(assigns(:topic)).to be_a_new Topic }
        it { expect(response).to render_template 'new' }
      end
    end
  
    describe "PUT update" do
      subject { patch :update, id: topic.to_param, topic: topic_attributes }

      describe "with valid params" do
        let(:new_name) { 'new-name' }
        let(:topic_attributes) { { name: new_name } }
        before { subject }

        it { expect(topic.reload.name).to eq new_name }
        it { expect(assigns(:topic)).to eq topic }
        it { expect(response).to redirect_to topic.reload }
        it { expect(flash[:notice]).to be_present }
      end
  
      describe "with invalid params" do
        let(:topic_attributes) { { name: nil } }
        before { subject }

        it { expect(assigns(:topic)).to eq topic }
        it { expect(response).to render_template 'edit' }
      end
    end
  
    describe "DELETE destroy" do
      subject { delete :destroy, id: topic.to_param }

      it "destroys the requested topic"  do
        expect { subject }.to change(Topic, :count).by(-1)
      end

      describe "and" do
        before { subject }

        it { response.should redirect_to topics_url }
        it { expect(flash[:notice]).to be_present }
      end
    end
  end
end
