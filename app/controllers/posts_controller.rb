class PostsController < ApplicationController
  before_action :set_user, only: [:index, :show, :new, :create, :destroy]

  def index
  end

  def show
  end

  def new
    @post = @user.posts.new
  end

  def create
    @post = @user.posts.build(post_params)
    respond_to do |format| 
      if @post.save
        format.html { redirect_to user_posts_path(@user), notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

end
