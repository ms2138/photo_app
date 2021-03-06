class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]
  after_action :verify_authorized

  def index
    @users = authorize User.order("created_at").page(params[:page]).per(10)
  end

  def show
      @posts = Post.includes(:user).where(user_id: @user.id).limit(5).order("created_at DESC").page(params[:page]).per(4)
      @liked = @user.liked.with_attached_images.limit(5).order("created_at DESC").page(params[:page]).per(4)
  end

  def edit
  end

  def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_path, flash: { success: "User successfully deleted." } }
      end
  end

  def following
    @user = authorize User.find_by(id: params[:id])
    @following = @user.following.order("created_at").page(params[:page]).per(3)
  end

  def followers
    @user = authorize User.find_by(id: params[:id])
    @followers = @user.followers.order("created_at").page(params[:page]).per(3)
  end

  private

  def set_user
    @user = authorize User.find_by(id: params[:id])
  end
end
