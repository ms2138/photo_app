class CommentsController < ApplicationController
    after_action :verify_authorized

    def index
        @comments = authorize @post.comments.includes(:user)
    end

    def new
        @comment = authorize current_user.comments.new
    end
    
    def create
        @comment = authorize current_user.comments.build(comment_params)
        respond_to do |format| 
            if @comment.save
                @post = @comment.post
                format.js
            else
                format.html { redirect_to user_post_path(current_user, @post), alert: "Failed to create comment." }
            end
        end
    end
    
    def destroy
        @comment = authorize Comment.find(params[:id])
        @post = @comment.post
        if @comment.destroy
            respond_to :js
        else
            format.html { redirect_to user_post_path(current_user, @post), alert: "Failed to create comment." }
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :content)
    end
end
