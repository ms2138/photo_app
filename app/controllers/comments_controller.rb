class CommentsController < ApplicationController
    after_action :verify_authorized

    def index
      @comments = authorize @post.comments.includes(:user)
    end

    private

    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :content)
    end
end
