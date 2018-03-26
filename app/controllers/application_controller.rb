class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  helper_method :current_order

  include SessionsHelper

  def current_order
    if !session[:order_id].nil?
      @order = Order.find(session[:order_id])
    else
      @order = Order.new
      @order.order_status_id = 1
      @order
    end
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

    
end
