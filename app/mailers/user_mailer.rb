class UserMailer < ApplicationMailer
  default from: 'bettmo1209@outlook.com'
    def account_confirmation(user)
        @user = user
        mail(to: @user.email, subject: 'Please confirm your account')
      end
end
