class ApplicationMailer < ActionMailer::Base
  default from: Settings.mail.default_mail
  layout "mailer"
end
