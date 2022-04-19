class SearchController < ApplicationController
  def index
    if params[:query].start_with?('#')
      query = params[:query].gsub('#', '')
      @posts = authorize Post.joins(:hash_tags).where(hash_tags: {name: query}).with_attached_images.order("created_at").page(params[:page]).per(10)
    else
      @posts = authorize Post.where("content like ?", "%#{params[:query]}%").with_attached_images.order("created_at").page(params[:page]).per(10)
    end
  end
end
