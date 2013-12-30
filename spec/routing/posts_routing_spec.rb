require "spec_helper"

describe PostsController do
  describe "routing" do

    it { expect(get '/posts'       ).to route_to('posts#index') }
    it { expect(get "/posts/new"   ).to route_to("posts#new") }
    it { expect(get "/posts/1"     ).to route_to("posts#show", id: '1') }
    it { expect(get "/posts/1/edit").to route_to("posts#edit", id: '1') }
    it { expect(post "/posts"      ).to route_to("posts#create") }
    it { expect(put "/posts/1"     ).to route_to("posts#update", id: '1') }
    it { expect(delete "/posts/1"  ).to route_to("posts#destroy", id: '1') }
  end
end
