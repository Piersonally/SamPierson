require "spec_helper"

describe AccountsController do
  describe "routing" do
    it { expect(get '/signup'      ).to route_to('accounts#new') }
    it { expect(get '/accounts/new').to route_to('accounts#new') }
    it { expect(post '/accounts'   ).to route_to('accounts#create') }
  end
end
