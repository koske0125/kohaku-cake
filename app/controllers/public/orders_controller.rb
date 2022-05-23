class Public::OrdersController < ApplicationController

  def new
    @order = current_customer.orders.new
    @customer = Customer.find(current_customer.id)
    @address = @customer.addresses
  end

  def confirm
    @order = current_customer.orders.new(order_params)
    @address_select = address_select_params[:address_select].to_i
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800
    @total_price = 0
    @customer = Customer.find(current_customer.id)

    if @address_select == 1
      @send_address = Address.find(address_select_params[:address_id])
    end

  end

  def complete

  end

  def create
    @order = current_customer.orders.new(order_params) #支払い方法・送料・請求額・顧客idが入っている状態


  end

  def index

  end

  def show

  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :address, :name, :shipping_cost, :postal_code, :total_payment)
  end

  def address_select_params
    params.require(:order).permit(:address_select, :address_id)
  end

end
