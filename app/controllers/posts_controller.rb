class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy, :like, :unlike]
  before_action :set_user, only: [:index, :show, :new, :create, :destroy, :like, :unlike]
  after_action :verify_authorized

  def index
    @posts = @user.posts.with_attached_images.order("created_at").page(params[:page]).per(10)
    authorize @posts
  end

  def show
  end

  def new
    @post = authorize @user.posts.new
  end

  def create
    @post = authorize @user.posts.build(post_params)
    respond_to do |format| 
      if @post.save
        format.html { redirect_to user_posts_path(@user), notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def like
    @post.liked_by current_user
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@post, partial: 'posts/like', locals: { post: @post })
      end
    end
  end

  def unlike
    @post.unliked_by current_user
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@post, partial: 'posts/unlike', locals: { post: @post })
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
    redirect_to root_url if @user.nil?
  end

  def set_post
    @post = authorize Post.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

end
