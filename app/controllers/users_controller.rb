class UsersController < ApplicationController
    before_action :set_user, only: [:show, :destroy]

    def show
        @posts = Post.includes(:user).where(user_id: @user.id).limit(5).order("created_at").page(params[:page]).per(3)
      end

    def destroy
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_path, flash: { success: "User successfully deleted." } }
        end
    end

    private
  
    def set_user
      @user = User.find_by(id: params[:user_id])
    end
end