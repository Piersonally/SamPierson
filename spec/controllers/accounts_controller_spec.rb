require 'spec_helper'

describe AccountsController do

  describe "#new" do
    subject { get :new }

    context "if signup is disabled" do
      before { controller.stub(:signup_enabled?){ false } }

      before { subject }
      it { should redirect_to root_path }
      it { expect(flash[:alert]).to be_present }
    end

    context "if signup is enaabled" do
      before { controller.stub(:signup_enabled?){ true } }

      before { subject }
      it { expect(response).to render_template :new }
      it { expect(assigns :account).to be_a_new Account }
    end
  end

  describe "#create" do
    subject { post :create, account: account_params }

    describe "with invalid params" do
      let(:account_params) { { email: '' } }

      context "if signup is disabled" do
        before { controller.stub(:signup_enabled?){ false } }

        before { subject }
        it { should redirect_to root_path }
        it { expect(flash[:alert]).not_to be_blank }
      end

      context "if signup is enaabled" do
        before { controller.stub(:signup_enabled?){ true } }

        it { expect { subject }.not_to change(Account, :count) }
        it { expect(subject).to render_template :new }
        it "should set errors" do
          subject
          account = assigns :account
          expect(account).to have(1).errors_on :email
          expect(account).to have(1).errors_on :first_name
          expect(account).to have(1).errors_on :last_name
          expect(account).to have(1).errors_on :password
        end
      end
    end

    describe "with valid params" do
      let(:account_params) {
        {
          email: 'foo@example.com',
          first_name: 'First', last_name: 'Last',
          password: 'secret', password_confirmation: 'secret'
        }
      }
      let(:account) { account = Account.last }

      context "if signup is disabled" do
        before { controller.stub(:signup_enabled?){ false } }

        before { subject }
        it { should redirect_to root_path }
        it { expect(flash[:alert]).to be_present }
      end

      context "if signup is enaabled" do
        before { controller.stub(:signup_enabled?){ true } }

        it "should create a new account" do
          expect { subject }.to change(Account, :count).by(1)
          expect(account.email).to eq 'foo@example.com'
          expect(account.full_name).to eq 'First Last'
        end

        it "should leave the new user logged in" do
          subject
          session[:account_id].should == assigns(:account).id
        end

        it { expect(subject).to redirect_to root_path }
        it { subject ; expect(flash[:notice]).not_to be_blank }
      end
    end
  end
end
