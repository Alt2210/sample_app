class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t("activerecord.flash.actions.activate")
      redirect_to user
    else
      flash[:danger] = t("activerecord.flash.danger.activate_fail")
      redirect_to root_url
    end
  end
end
