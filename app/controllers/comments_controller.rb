class CommentsController < ApplicationController
    after_action :verify_authorized

    def index
      @comments = authorize @post.comments.includes(:user)
    end
    
end
