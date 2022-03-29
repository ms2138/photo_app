class CommentsController < ApplicationController
    before_action :set_user, only: [:new, :create]
    after_action :verify_authorized

    def new
        @comment = authorize @user.comments.new
    end
    
    def create
        @comment = authorize @user.comments.build(comment_params)
        respond_to do |format| 
            if @comment.save
                @post = @comment.post
                format.turbo_stream do
                   render turbo_stream:  [
                    turbo_stream.update('new_comment', partial: 'comments/form', locals: { user: @user, post: @post, comment: Comment.new } ),
                    turbo_stream.prepend('comments', partial: 'comments/comment', locals: { user: @user, post: @post, comment: @comment } )
                ]
                end
            else
                format.html { redirect_to user_post_path(current_user, @post), alert: "Failed to create comment." }
            end
        end
    end
    
    def destroy
        @comment = authorize Comment.find(params[:id])
        @post = @comment.post
        respond_to do |format| 
            if @comment.destroy
                format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
            else
                format.html { redirect_to user_post_path(current_user, @post), alert: "Failed to create comment." }
            end
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :content)
    end
    
    def set_user
        @user =  User.find_by(id: params[:user_id])
        redirect_to root_url if @user.nil?
    end
end
