require 'spec_helper'

describe OauthResponse do
  let(:oauth_data) { YAML::load_file fixture_file_path('oauth_response.yml') }
  subject { OauthResponse.new oauth_data }

  its(:first_name) { should eq "Sam" }
  its(:last_name) { should eq "Pierson" }
  its(:email) { should eq "sam@example.com" }
  its(:uid) { should eq "441066" }
  its(:gravatar_id) { should eq "e0e82cf76295338274c08b92840fe1fa" }

  context "when the user has no name" do
    before { oauth_data["info"]["name"]= "" }

    it "should raise an exception" do
      expect { subject }.to raise_error
    end
  end
  context "When the name has only one word" do
    before { oauth_data["info"]["name"]= "Cher" }

    it "should duplicate that word in first and last name" do
      expect(subject.first_name).to eq "Cher"
      expect(subject.last_name).to eq "Cher"
    end
  end

  context "When the name has more than 2 words" do
    before { oauth_data["info"]["name"]= "Boutros Boutros Ghali" }

    describe "it should group everthing but the last name into first_name" do
      its(:first_name) { should eq "Boutros Boutros" }
      its(:last_name) { should eq "Ghali" }
    end
  end
end
