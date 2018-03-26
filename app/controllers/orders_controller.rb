class OrdersController < ApplicationController
  
  def index
    @orders = Order.paginate(page: params[:page], per_page: 10)
    render :layout => 'admin_layout'
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = current_order
    @order.user_id = current_user.id
  end

  def show
    @order = current_order
  end

  def edit
    @order = Order.find(params[:id])
    @order_status = OrderStatus.all.map{|c| [ c.name, c.id ] }
    @user = User.find(@order.user_id)
    render :layout => 'admin_layout'
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(user_params)
      @order.user_id ||= current_user.id
      if current_user.admin?
        @order.save
        session.delete(:order_id)
        flash[:success] = "Order updated"
        redirect_to admin_orders_url
      else
        @order.set_shipped_status
        @order.save
        @order.send_sent_email
        session.delete(:order_id)
        flash[:success] = "Order placed"
        redirect_to root_url
      end
    else
      render 'edit'
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    flash[:success] = "Order deleted"
    redirect_to admin_orders_url
  end

  private

    def user_params
      params.require(:order).permit(:subtotal, :address, :password,
                                   :password_confirmation)
    end
end
