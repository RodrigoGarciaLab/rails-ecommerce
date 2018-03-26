class StaticPagesController < ApplicationController
  def home
    @products = Product.where(featured: true)
    @order_item = current_order.order_items.new
  end

  def contact
  end

  def admin
    render :layout => 'admin_layout'
  end
end
