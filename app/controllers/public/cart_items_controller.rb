class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = Customer.find(current_customer.id)
    @cart_items = @customer.cart_items
    @total_price = 0
  end

  def update

  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path, notice: "商品を削除しました"
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path, notice: "カート内商品をすべて削除しました"
  end

  def create
    if current_customer.cart_items.find_by(item_id: cart_item_params[:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
      @cart_item.amount += cart_item_params[:amount].to_i
      @cart_item.customer_id = cart_item_params[:customer_id]
      @cart_item.item_id = cart_item_params[:item_id]
      @cart_item.save
      redirect_to public_cart_items_path, notice: "商品を追加しました"
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.save
      redirect_to public_cart_items_path, notice: "商品を追加しました"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
