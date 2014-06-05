class UserNotifier < ActionMailer::Base
  default from: "luozhonghaizju@163.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier.reset_password.subject
  #
  def reset_password(mail_str,user,key)
    @greeting = "Hi"
    @pw_key = key
    @user = user.id
    mail to: mail_str
  end
end
