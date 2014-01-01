class HomeController < ApplicationController

  def index
    @articles = Article.published
  end
end
