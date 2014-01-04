class ArticlesController < LoggedInController
  respond_to :html, :js
  skip_before_filter :require_user_is_logged_in, only: :show

  def index
    @articles = current_user.articles
                            .order('published_at DESC')
                            .page(params[:page]).per(15)
    respond_with @articles
  end

  def show
    respond_with @article = article
  end

  def new
    @article_form = ArticleForm.new current_user.articles.new
  end

  def edit
    @article_form = ArticleForm.new article
  end

  def create
    @article_form = ArticleForm.new current_user.articles.new, article_params
    flash[:notice] = 'Article was successfully created.' if @article_form.save
    respond_with @article_form
  end

  def update
    @article_form = ArticleForm.new article
    if @article_form.update article_params
      flash[:notice] = 'Article was successfully updated.'
    end
    respond_with @article_form
  end

  def destroy
    article.destroy
    flash[:notice] = %(Article "#{article.title}" was successfully destroyed.)
    respond_with article
  end

  def publish
    unless article.published?
      @article.update_attributes! published_at: Time.now
      flash[:notice] = %(Article "#{article.title}" has been published.)
    end
    redirect_to article
  end

  private

  def article
    @article ||=
    if user_logged_in?
      Article.find_by_slug! params[:id]
    else
      Article.visible.find_by_slug! params[:id]
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :published_at, :visible)
  end
end
