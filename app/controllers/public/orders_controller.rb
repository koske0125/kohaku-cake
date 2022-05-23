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
    @order = current_customer.orders.new(order_params) #少なくとも支払い方法・送料・請求額・顧客idが入っている状態
    @address_select = address_select_params[:address_select].to_i
    @customer = Customer.find(current_customer.id)
    @cart_items = @customer.cart_items

    if @address_select == 0 #送り先がご自身の住所だった場合
       @order.postal_code = @customer.postal_code
       @order.address = @customer.address
       @order.name = @customer.last_name + " " + @current_customer.first_name

    elsif @address_select == 1 #送り先が登録済み住所だった場合
       @address = Address.find(address_select_params[:address_id].to_i)
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name

    else @address_select == 2 #送り先が新しい住所だった場合、住所・名前・郵便番号は入っている状態
         @new_address = Address.new
         @new_address.postal_code = @order.postal_code
         @new_address.address = @order.address
         @new_address.name = @order.name
         @new_address.customer_id = @customer.id
         @new_address.save
    end
    @order.status = "waiting_deposit"
    @order.save #注文情報を保存

    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item.id
      order_detail.price = cart_item.item.price
      order_detail.amount = cart_item.amount
      order_detail.making_status = "production_prohibition"
      order_detail.save
    end

    @cart_items.destroy_all

    redirect_to public_orders_complete_path
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
