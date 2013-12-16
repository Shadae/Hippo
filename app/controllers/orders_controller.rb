class OrdersController < ApplicationController
  before_action :set_order, except: [:new, :create]
  before_action :set_products, only: [:show, :add_product]

  def new
    @order = Order.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end
  
  def add_product
    @orderproduct = OrderProduct.new(order_id: current_order.id, product_id: params[:product_id])
      if @orderproduct.save
      redirect_to order_path(current_order) #changes url
    else 
      flash.now[:notice] = "There was a problem adding this item to the cart." #render doesn't show notice b/c generates page first
      render :"/product/show"      
    end
  end

  def remove_product
    @orderproduct = OrderProduct.find_by(order_id: current_order.id, product_id: params[:product_id])
    @orderproduct.destroy
    redirect_to order_path(current_order)
  end


private

  def set_order
    @order = current_order 
  end

  def set_products
    @products = current_order.products  #this returns objects-- iterate in HTML
  end
end


