class Public::HomesController < ApplicationController
  def top
    @Genres = Genre.all
    @items = Item.all
    @items = Item.all.order(created_at: :desc).limit(4)
  end

  def about
  end
end
