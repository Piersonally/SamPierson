class PostsController < LoggedInController
  respond_to :html
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish]

  def index
    @posts = current_user.posts.order 'published_at DESC'
    respond_with @posts
  end

  def show
    respond_with @post
  end

  def new
    @post = current_user.posts.new
    respond_with @post
  end

  def edit
    respond_with @post
  end

  def create
    @post = current_user.posts.new post_params
    flash[:notice] = 'Post was successfully created.' if @post.save
    respond_with @post
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post was successfully updated.'
    end
    respond_with @post
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post \"#{@post.title}\" was successfully destroyed."
    respond_with @post
  end

  def publish
    unless @post.published?
      @post.update_attributes! published_at: Time.now
      flash[:notice] = "Post \"#{@post.title}\" has been published."
    end
    redirect_to @post
  end

  private
    def set_post
      @post = current_user.posts.find_by_slug params[:id]
    end

    def post_params
      params.require(:post).permit(:title, :body, :published_at)
    end
end
