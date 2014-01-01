class HomeController < ApplicationController

  def index
    @articles = Article.visible
  end
end
