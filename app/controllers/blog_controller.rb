class BlogController < ApplicationController

  def show
    @blog_data = OpenStruct.new(
      articles: Article.visible,
      topics: Topic.topics_with_article_counts
    )
  end
end
