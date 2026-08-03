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

  def create_feed_item
    return unless logged_in?

    @pagy, @feed_items =
      pagy(current_user.feed,
           limit: Settings.pagination.microposts_per_page_10)
  end
end
