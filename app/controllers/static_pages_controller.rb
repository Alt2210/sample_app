class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in?
    create_feed_item
  end

  def help; end
end
