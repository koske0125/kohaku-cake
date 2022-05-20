class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit

  end

  def update

  end

  def unsubscribe

  end

  def withdraw

  end

end
