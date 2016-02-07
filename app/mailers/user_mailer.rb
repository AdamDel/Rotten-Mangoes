class UserMailer < ActionMailer::Base
  default from: 'notifications@example.com'
 
  def goodbye_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Goodbye')
  end
end