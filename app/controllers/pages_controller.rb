class PagesController < ApplicationController
  after_action :verify_authorized, only: [:feed]

  def about
  end

  def contact
  end

  def privacy
  end

  def feed
    @posts = current_user.feed.with_attached_images.order("created_at").page(params[:page]).per(10)
    authorize(@posts, policy_class: PagePolicy)
  end
end
