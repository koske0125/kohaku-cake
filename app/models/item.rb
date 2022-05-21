class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :genre_id, presence: true



  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end

  def add_tax_price
    (self.price * 1.10).round
  end

end
