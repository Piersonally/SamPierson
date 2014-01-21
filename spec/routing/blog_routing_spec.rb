require "spec_helper"

describe BlogController do
  describe "routing" do

    it { expect(get "/"        ).to route_to("blog#show") }
    it { expect(get "/blog"    ).to route_to("blog#show") }
    it { expect(get "/blog/rss").to route_to("blog#rss") }
  end
end
