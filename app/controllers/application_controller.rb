class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Method

  around_action :switch_locale

  private

  def switch_locale(&)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &)
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t("activerecord.flash.danger.login_required")
    store_location
    redirect_to login_url
  end
end
