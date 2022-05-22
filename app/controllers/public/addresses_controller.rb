class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @address.customer_id = current_customer.id
    @customer = current_customer
    @addresses = @customer.addresses
  end

  def edit

  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to public_addresses_path, notice: "配送先を新規登録しました"
    else
    @customer = current_customer
    @addresses = @customer.addresses
      render 'index'
    end
  end

  def update

  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path, notice: "配送先を削除しました"

  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
