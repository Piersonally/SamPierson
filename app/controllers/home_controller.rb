class HomeController < ApplicationController

  def index
    @index_page_data = OpenStruct.new(
      articles: Article.visible,
      topics: Topic.topics_with_article_counts
    )
  end
end
