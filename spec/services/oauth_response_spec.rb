require 'spec_helper'

describe OauthResponse do
  let(:oauth_data) { YAML::load_file fixture_file_path('oauth_response.yml') }
  subject { OauthResponse.new oauth_data }

  its(:first_name) { should eq "Sam" }
  its(:last_name) { should eq "Pierson" }
  its(:email) { should eq "sam@example.com" }
  its(:uid) { should eq "441066" }
  its(:gravatar_id) { should eq "e0e82cf76295338274c08b92840fe1fa" }
end
