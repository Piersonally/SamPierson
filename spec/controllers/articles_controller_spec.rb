require 'spec_helper'

describe ArticlesController do
  let(:author) { FactoryGirl.create :admin_account }
  let!(:article1) { FactoryGirl.create :article, author: author }
  let!(:article2) { FactoryGirl.create :article }
  
  let(:valid_attributes) { {title: "Sex life of the Ping Pong ball" } }

  context "while not logged in" do
    describe "GET index" do
      # TODO test it requires user to be logged in to access ALL actions
      subject { get :index }
      
      it { expect(subject).to redirect_to login_path }
      it { subject; expect(flash[:alert]).to be_present }
    end

    describe "GET show" do
      subject { get :show, id: article.to_param }

      context "for an invisible article" do
        let(:article) { FactoryGirl.create :article }

        it "should raise an error" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "for a visible article" do
        let(:article) { FactoryGirl.create :published_article }

        it { should render_template 'show' }
      end
    end
  end
  
  context "while logged in" do
    before { session[:account_id] = author.id }
    
    describe "GET index" do
      before { get :index }

      it { expect(assigns(:articles)).to eq [article1, article2] }
      it { expect(response).to render_template 'index' }
    end
  
    describe "GET show" do
      before { get :show, id: article1.to_param }

      it { expect(assigns(:article)).to eq article1 }
      it { expect(response).to render_template 'show' }
    end
  
    describe "GET new" do
      before { get :new }

      it { expect(assigns :article_form).to be_a ArticleForm }
      it { expect(assigns(:article_form).article).to be_a_new Article }
      it { expect(response).to render_template 'new' }
    end
  
    describe "GET edit" do
      before { get :edit, id: article1.to_param }

      it { expect(assigns :article_form).to be_a ArticleForm }
      it { expect(assigns(:article_form).article).to eq article1 }
      it { expect(response).to render_template 'edit' }
    end
  
    describe "POST create" do
      subject { post :create, article: article_attributes }

      describe "with valid params" do
        let(:title) { 'The Sex Life of the Ping Pong Ball' }
        let(:article_attributes) { { title: title, topic_names: "tag1, tag2" } }
        let(:created_article) { Article.last }

        it "creates a new Article" do
          expect { subject }.to change(Article, :count).by(1)
        end

        describe "and" do
          before { subject }

          it { expect(assigns(:article_form).article).to eq created_article }
          it { expect(created_article.author_id).to eq author.id }
          it { expect(created_article.title).to eq title }
          it { expect(created_article.topics.size).to eq 2 }
          it { expect(created_article.topics.map(&:name)).to eq %w(tag1 tag2) }
          it { expect(flash[:notice]).to be_present }
          it { should redirect_to created_article }
        end
      end
  
      describe "with invalid params" do
        let(:article_attributes) { { title: nil } }
        before { subject }

        it { expect(assigns :article_form).to be_a ArticleForm }
        it { expect(assigns(:article_form).article).to be_a_new Article }
        it { expect(flash[:notice]).to be_blank }
        it { expect(response).to render_template 'new' }
      end
    end
  
    describe "PUT update" do
      subject { patch :update, id: article1.to_param, article: article_attributes }

      describe "with valid params" do
        let(:new_body) { 'New Body' }
        let(:article_attributes) { { body: new_body } }
        before { subject }

        it { expect(article1.reload.body).to eq new_body }
        it { expect(assigns(:article)).to eq article1 }
        it { expect(response).to redirect_to article1 }
        it { expect(flash[:notice]).to be_present }
      end
  
      describe "with invalid params" do
        let(:article_attributes) { { title: nil } }
        before { subject }

        it { expect(assigns(:article)).to eq article1 }
        it { expect(response).to render_template 'edit' }
      end
    end
  
    describe "DELETE destroy" do
      subject { delete :destroy, id: article1.to_param }

      it "destroys the requested article"  do
        expect { subject }.to change(Article, :count).by(-1)
      end

      describe "and" do
        before { subject }

        it { response.should redirect_to articles_url }
        it { expect(flash[:notice]).to be_present }
      end
    end

    describe "PATCH publish" do
      let(:article) { article1 }

      subject { patch :publish, id: article.to_param }

      context "for an already published article" do
        before { article.update_column :published_at, 1.day.ago }

        it "should not change the article's published_at" do
          expect {
            subject
          }.not_to change(article.reload, :published_at)
        end
      end

      context "for an unpublished article" do
        it "should set published_at" do
          subject
          expect(article.reload.published_at).to be_within(3.seconds).of(Time.now)
        end

        context "and" do
          before { subject }
          it { expect(flash[:notice]).to be_present }
          it { expect(response).to redirect_to article1 }
        end
      end
    end
  end
end
