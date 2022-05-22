class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
    else
      @items = Item.search(params[:search])
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
