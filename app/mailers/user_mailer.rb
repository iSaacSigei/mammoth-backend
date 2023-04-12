class UserMailer < ApplicationMailer
    def account_confirmation(user)
        @user = user
        mail(to: @user.email, subject: 'Please confirm your account')
      end
end
