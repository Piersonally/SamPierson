require "spec_helper"

describe SessionsController, type: :routing do
  describe "routing" do
    it { expect(get  '/login').to route_to 'sessions#new' }
    it { expect(post '/login').to route_to 'sessions#create' }
    it do
      expect(
        get '/auth/github/callback'
      ).to route_to('sessions#create_oauth', provider: 'github')
    end
  end
end
