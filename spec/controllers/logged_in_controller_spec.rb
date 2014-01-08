require 'spec_helper'

describe LoggedInController do
  controller(LoggedInController) do
    def index
      raise NotAuthorizedError
    end
  end

  context "while logged in" do
    let(:user) { FactoryGirl.create :account }
    before { session[:account_id] = user.id }

    describe "handling NotAuthorized exceptions" do
      it "redirects to the home page with an error" do
        get :index
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to be_present
      end
    end
  end
end
