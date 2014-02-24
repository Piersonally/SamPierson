require 'spec_helper'

describe QuotationsController do

  it_should_behave_like "requires login for actions", [
    [ :get,    :index,   { }              ],
    [ :get,    :new,     { }              ],
    [ :post,   :create,  { title: 'foo' } ],
    [ :get,    :edit,    { id: 1 }        ],
    [ :patch,  :update,  { id: 1 }        ],
    [ :delete, :destroy, { id: 1 }        ]
  ]

  let(:quoter) { FactoryGirl.create :admin_account }
  let!(:quote1) { FactoryGirl.create :quotation, quoter: quoter }
  let!(:quote2) { FactoryGirl.create :quotation }
  let(:valid_attributes) {
    {
      author: "Sex life of the Ping Pong ball",
      quote: "Sex life of the Ping Pong ball"
    }
  }

  context "while not logged in" do
    describe "GET show" do
      subject { get :show, id: quote1.to_param }
      before { subject }

      it { expect(response).to render_template 'show' }
      it { expect(assigns :quote).to eq quote1 }
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
    before { session[:account_id] = quoter.id }
    
    describe "GET index" do
      before { get :index }

      it { expect(assigns(:quotes)).to eq [quote1, quote2] }
      it { expect(response).to render_template 'index' }
    end
  
    describe "GET show" do
      before { get :show, id: quote1.to_param }

      it { expect(assigns(:quote)).to eq quote1 }
      it { expect(response).to render_template 'show' }
    end
  
    describe "GET new" do
      before { get :new }

      it { expect(assigns :quote).to be_a_new Quotation }
      it { expect(response).to render_template 'new' }
    end
  
    describe "GET edit" do
      before { get :edit, id: quote1.to_param }

      it { expect(assigns :quote).to eq quote1 }
      it { expect(response).to render_template 'edit' }
    end
  
    describe "POST create" do
      subject { post :create, quotation: quote_attributes }

      describe "with valid params" do
        let(:author) { 'quotation author' }
        let(:quote) { 'something terribly witty' }
        let(:source) { 'a book perhaps' }
        let(:_when) { 'year, maybe month' }
        let(:quote_attributes) {
          { author: author, quote: quote, source: source, when: _when }
        }
        let(:created_quote) { Quotation.last }

        it "creates a new Quotation" do
          expect { subject }.to change(Quotation, :count).by(1)
        end

        describe "and" do
          before { subject }

          it { expect(assigns :quote).to eq created_quote }
          it { expect(created_quote.quoter_id).to eq quoter.id }
          it { expect(created_quote.author).to eq author }
          it { expect(created_quote.quote).to eq quote }
          it { expect(created_quote.source).to eq source }
          it { expect(created_quote.when).to eq _when }
          it { expect(flash[:notice]).to be_present }
          it { should redirect_to created_quote }
        end
      end
  
      describe "with invalid params" do
        let(:quote_attributes) { { quote: nil } }
        before { subject }

        it { expect(assigns :quote).to be_a_new Quotation }
        it { expect(flash[:notice]).to be_blank }
        it { expect(response).to render_template 'new' }
      end
    end
  
    describe "PUT update" do
      subject { patch :update, id: quote1.to_param, quotation: quote_attributes }

      describe "with valid params" do
        let(:new_quote) { 'Something else witty' }
        let(:quote_attributes) { { quote: new_quote } }
        before { subject }

        it { expect(quote1.reload.quote).to eq new_quote }
        it { expect(assigns :quote).to eq quote1 }
        it { expect(response).to redirect_to quote1 }
        it { expect(flash[:notice]).to be_present }
      end
  
      describe "with invalid params" do
        let(:quote_attributes) { { quote: nil } }
        before { subject }

        it { expect(assigns :quote).to eq quote1 }
        it { expect(response).to render_template 'edit' }
      end
    end
  
    describe "DELETE destroy" do
      subject { delete :destroy, id: quote1.to_param }

      it "destroys the requested quote"  do
        expect { subject }.to change(Quotation, :count).by(-1)
      end

      describe "and" do
        before { subject }

        it { response.should redirect_to quotations_url }
        it { expect(flash[:notice]).to be_present }
      end
    end
  end
end
