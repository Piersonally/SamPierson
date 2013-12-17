require 'spec_helper'

describe SessionsController do
  let(:account) { FactoryGirl.create :account }

  describe "GET new" do
    subject { get 'new' }

    it { expect(subject).to render_template 'new' }
  end

  describe "POST create" do
    subject { post 'create', create_params }

    context "with invalid params" do
      let(:create_params) {
        { email: 'foo@bar.com', password: 'wrong password' }
      }
      before { subject }

      it { expect(response).to be_success }
      it { expect(response).to render_template 'new' }
      it { expect(flash[:alert]).not_to be_blank }
      it { expect(session[:account_id]).to be_blank }
    end

    context "with valid params" do
      let(:create_params) { {email: account.email, password: 'secret' } }
      before { subject }

      it { expect(response).to redirect_to root_path }
      it { expect(flash[:notice]).not_to be_blank }
      it { expect(session[:account_id]).to eq account.id }
    end
  end

  describe "DELETE destroy" do
    subject { delete :destroy }

    context "if someone is logged in" do
      before { session[:account_id] = account.id }
      before { subject }

      it "should log the user out (clear account_id from the session)" do
        expect(session).not_to have_key(:account_id)
      end
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:notice]).not_to be_blank }
    end
  end
end
