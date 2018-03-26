class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end

  def order_sent(order)
    @order = order
    @user  = User.find(@order.user_id)
    mail to: @user.email, subject: "Your order has been shipped!"
  end
end