require 'spec_helper'

describe SlideShowsController do

  it_should_behave_like "requires login for actions", [
    [ :get,    :index,   { }              ],
    [ :get,    :new,     { }              ],
    [ :post,   :create,  { title: 'foo' } ],
    [ :get,    :edit,    { id: 1 }        ],
    [ :patch,  :update,  { id: 1 }        ],
    [ :delete, :destroy, { id: 1 }        ]
  ]

  let(:author) { FactoryGirl.create :admin_account }
  let!(:slide_show1) { FactoryGirl.create :slide_show, author: author }
  let!(:slide_show2) { FactoryGirl.create :slide_show }
  let(:valid_attributes) { {title: "Sex life of the Ping Pong ball"} }

  context "while not logged in" do
    describe "GET show" do
      subject { get :show, id: slide_show1.to_param }

      it { should render_template 'show' }
    end
  end

  context "when logged in as a regular user" do
    let(:user) { FactoryGirl.create :account }
    before { session[:account_id] = user.id }

    describe "authorization" do
      before { bypass_rescue }
      it { expect { get :index             }.to raise_error NotAuthorizedError }
      it { expect { get :new               }.to raise_error NotAuthorizedError }
      it { expect { post :create           }.to raise_error NotAuthorizedError }
      it { expect { get :edit, id: 1       }.to raise_error NotAuthorizedError }
      it { expect { patch :update, id: 1   }.to raise_error NotAuthorizedError }
      it { expect { delete :destroy, id: 1 }.to raise_error NotAuthorizedError }
    end
  end
  
  context "while logged in as an admin" do
    before { session[:account_id] = author.id }
    
    describe "GET index" do
      before { get :index }

      it { expect(assigns(:slide_shows)).to eq [slide_show1, slide_show2] }
      it { expect(response).to render_template 'index' }
    end
  
    describe "GET show" do
      before { get :show, id: slide_show1.to_param }

      it { expect(assigns(:slide_show)).to eq slide_show1 }
      it { expect(response).to render_template 'show' }
    end
  
    describe "GET new" do
      before { get :new }

      it { expect(assigns :slide_show).to be_a SlideShow }
      it { expect(assigns :slide_show).to be_a_new SlideShow }
      it { expect(response).to render_template 'new' }
    end
  
    describe "GET edit" do
      before { get :edit, id: slide_show1.to_param }

      it { expect(assigns :slide_show).to be_a SlideShow }
      it { expect(assigns :slide_show).to eq slide_show1 }
      it { expect(response).to render_template 'edit' }
    end
  
    describe "POST create" do
      subject { post :create, slide_show: slide_show_attributes }

      describe "with valid params" do
        let(:title) { 'The Sex Life of the Ping Pong Ball' }
        let(:slide_show_attributes) { { title: title, topic_names: "tag1, tag2" } }
        let(:created_slide_show) { SlideShow.last }

        it "creates a new SlideShow" do
          expect { subject }.to change(SlideShow, :count).by(1)
        end

        describe "and" do
          before { subject }

          it { expect(assigns :slide_show).to eq created_slide_show }
          it { expect(created_slide_show.author_id).to eq author.id }
          it { expect(created_slide_show.title).to eq title }
          it { expect(flash[:notice]).to be_present }
          it { should redirect_to created_slide_show }
        end
      end
  
      describe "with invalid params" do
        let(:slide_show_attributes) { { title: nil } }
        before { subject }

        it { expect(assigns :slide_show).to be_a SlideShow }
        it { expect(assigns :slide_show).to be_a_new SlideShow }
        it { expect(flash[:notice]).to be_blank }
        it { expect(response).to render_template 'new' }
      end
    end
  
    describe "PUT update" do
      subject { patch :update, id: slide_show1.to_param, slide_show: slide_show_attributes }

      describe "with valid params" do
        let(:new_content) { 'New Body' }
        let(:slide_show_attributes) { { content: new_content } }
        before { subject }

        it { expect(slide_show1.reload.content).to eq new_content }
        it { expect(assigns(:slide_show)).to eq slide_show1 }
        it { expect(response).to redirect_to slide_show1 }
        it { expect(flash[:notice]).to be_present }
      end
  
      describe "with invalid params" do
        let(:slide_show_attributes) { { title: nil } }
        before { subject }

        it { expect(assigns(:slide_show)).to eq slide_show1 }
        it { expect(response).to render_template 'edit' }
      end
    end
  
    describe "DELETE destroy" do
      subject { delete :destroy, id: slide_show1.to_param }

      it "destroys the requested slide_show"  do
        expect { subject }.to change(SlideShow, :count).by(-1)
      end

      describe "and" do
        before { subject }

        it { response.should redirect_to slide_shows_url }
        it { expect(flash[:notice]).to be_present }
      end
    end
  end
end
