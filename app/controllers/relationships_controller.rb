class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :create
  before_action :load_relationship, only: :destroy

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.turbo_stream
    end
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.turbo_stream
    end
  end

  private

  def load_user
    return if @user = User.find_by(id: params[:followed_id])

    flash[:warning] = t("activerecord.flash.warnings.not_found_user")
    redirect_to root_path
  end

  def load_relationship
    return if @relationship = Relationship.find_by(id: params[:id])

    flash[:warning] = t("activerecord.flash.warnings.not_found_relationship")
    redirect_to root_path
  end
end
