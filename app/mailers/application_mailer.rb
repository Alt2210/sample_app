class ApplicationMailer < ActionMailer::Base
  default from: Settings.mail.default_mail
  layout "mailer"

  def default_url_options
    (super || {}).merge(locale: I18n.locale)
  end
end
