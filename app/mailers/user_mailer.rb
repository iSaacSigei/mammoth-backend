class UserMailer < ApplicationMailer
  default from: 'bettmo1209@outlook.com'
  
  def account_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'Please confirm your account')
  end
  
  def send_quotation_email(user, admin, land)
    @user = user
    @admin = admin
    @land = land
    mail(to: @user.email, subject: "Quotation for #{user.username}")
  end
  
  def quotation_accepted_email(land)
    @land = land
    @user = land.user
    mail(to: @user.email, subject: 'Quotation Accepted')
  end
  
  def quotation_declined_email(land)
    @land = land
    @user = land.user
    mail(to: @user.email, subject: 'Quotation Declined')
  end
end
