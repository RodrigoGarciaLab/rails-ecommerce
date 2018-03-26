class CartsController < ApplicationController
  before_action :logged_in_user
  def show
    @order_items = current_order.order_items
    @order.user_id = current_user.id
  end
end
