require "spec_helper"

describe HomeController do
  describe "routing" do

    it { expect(get "/about").to route_to("home#about") }
  end
end
