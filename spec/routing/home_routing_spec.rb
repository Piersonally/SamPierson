require "spec_helper"

describe HomeController, type: :routing do
  describe "routing" do

    it { expect(get "/about").to route_to("home#about") }
  end
end
