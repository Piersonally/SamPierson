require 'spec_helper'

describe OauthAccountManager do
  describe "#account_for" do
    let(:oauth_data) { YAML::load_file fixture_file_path('oauth_response.yml') }
    let(:oauth_response) { OauthResponse.new oauth_data }
    let(:provider) { 'github' }
    let(:account_manager) { OauthAccountManager.new provider }
    subject { account_manager.account_for oauth_response }

    context "given oauth data for an existing account" do
      let(:uid) { "123456" }
      let!(:account) { FactoryGirl.create :account, oauth_provider: provider,
                                                    oauth_uid: uid }
      before { oauth_data['uid'] = uid }

      it "should not create a new user" do
        expect { subject }.not_to change(Account, :count)
      end

      it "should return the existing account" do
        expect(subject).to eq account
      end

      context "if the oauth info has changed for this user" do
        let(:new_email) { 'new_email@example.com' }
        before { oauth_data["info"]["email"] = new_email }

        it "should update the account record with the new data" do
          subject
          expect(account.reload.email).to eq new_email
        end
      end
    end

    context "given oauth data for a new user" do
      it "should create a new user" do
        expect { subject }.to change(Account, :count).by(1)
        account = Account.last
        expect(account.email).to eq oauth_data["info"]["email"]
      end

      it "should return the new user" do
        expect(subject).to eq Account.last
      end
    end
  end
end
