require "spec_helper"

describe ArticlesController do
  describe "routing" do

    it { expect(get '/articles'            ).to route_to('articles#index') }
    it { expect(get "/articles/new"        ).to route_to("articles#new") }
    it { expect(get "/articles/1"          ).to route_to("articles#show", id: '1') }
    it { expect(get "/articles/1/edit"     ).to route_to("articles#edit", id: '1') }
    it { expect(post "/articles"           ).to route_to("articles#create") }
    it { expect(patch "/articles/1"        ).to route_to("articles#update", id: '1') }
    it { expect(delete "/articles/1"       ).to route_to("articles#destroy", id: '1') }
    it { expect(patch "/articles/1/publish").to route_to("articles#publish", id: '1') }
  end
end
