require 'spec_helper'

describe PostsController do
  let(:author) { FactoryGirl.create :account }
  let!(:authors_post) { FactoryGirl.create :post, author: author }
  let!(:other_post) { FactoryGirl.create :post }
  
  let(:valid_attributes) { {title: "Sex life of the Ping Pong ball" } }

  # TODO it should require user to be logged in to access ALL actions
  
  context "while not logged in" do
    describe "GET index" do
      subject { get :index }
      
      it { expect(subject).to redirect_to login_path }
      it { subject; expect(flash[:alert]).to be_present }
    end
  end
  
  context "while logged in as the blog author" do
    before { session[:account_id] = author.id }
    
    describe "GET index" do
      before { get :index }

      it { expect(assigns(:posts)).to eq [authors_post] }
      it { expect(response).to render_template 'index' }
    end
  
    describe "GET show" do
      before { get :show, id: authors_post.to_param }

      it { expect(assigns(:post)).to eq authors_post }
      it { expect(response).to render_template 'show' }
    end
  
    describe "GET new" do
      before { get :new }

      it { expect(assigns(:post)).to be_a_new Post }
      it { expect(response).to render_template 'new' }
    end
  
    describe "GET edit" do
      before { get :edit, id: authors_post.to_param }

      it { expect(assigns(:post)).to eq authors_post }
      it { expect(response).to render_template 'edit' }
    end
  
    describe "POST create" do
      subject { post :create, post: post_attributes }

      describe "with valid params" do
        let(:title) { 'The Sex Life of the Ping Pong Ball' }
        let(:post_attributes) { { title: title } }
        let(:created_post) { Post.last }

        it "creates a new Post" do
          expect {
            subject
          }.to change(Post, :count).by(1)
        end

        describe "and" do
          before { subject }

          it { expect(assigns :post).to eq created_post }
          it { expect(created_post.author_id).to eq author.id }
          it { expect(created_post.title).to eq title }
          it { should redirect_to created_post }
          it { expect(flash[:notice]).to be_present }
        end
      end
  
      describe "with invalid params" do
        let(:post_attributes) { {title: nil} }
        before { subject }

        it { expect(assigns(:post)).to be_a_new Post }
        it { expect(response).to render_template 'new' }
      end
    end
  
    describe "PUT update" do
      subject { patch :update, id: authors_post.to_param, post: post_attributes }

      describe "with valid params" do
        let(:new_body) { 'New Body' }
        let(:post_attributes) { { body: new_body } }
        before { subject }

        it { expect(authors_post.reload.body).to eq new_body }
        it { expect(assigns(:post)).to eq authors_post }
        it { expect(response).to redirect_to authors_post }
        it { expect(flash[:notice]).to be_present }
      end
  
      describe "with invalid params" do
        let(:post_attributes) { { title: nil } }
        before { subject }

        it { expect(assigns(:post)).to eq authors_post }
        it { expect(response).to render_template 'edit' }
      end
    end
  
    describe "DELETE destroy" do
      subject { delete :destroy, id: authors_post.to_param }

      it "destroys the requested post"  do
        expect { subject }.to change(Post, :count).by(-1)
      end
  
      it "redirects to the posts list" do
        subject
        response.should redirect_to posts_url
      end
    end
  end
end
