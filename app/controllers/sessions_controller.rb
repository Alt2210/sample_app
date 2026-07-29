class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params.dig(:session, :email)&.downcase)

    unless user&.authenticate(params.dig(:session, :password))
      flash.now[:danger] =
        t("sessions.flash.dangers.invalid_email_password_combination")
      return render("new", status: :unprocessable_entity)
    end

    check_activation_and_log_in user
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  private

  def check_activation_and_log_in user
    if user.activated?
      forwarding_url = session[:forwarding_url]
      reset_session
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      log_in user
      redirect_to forwarding_url || user
    else
      flash[:warning] =
        t("sessions.flash.warnings.account_not_activate")
      redirect_to root_url, status: :see_other
    end
  end
end
