class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true, length: {maximum: 200}
  validates :price, presence: true
  validates :genre_id, presence: true
  validates :image, presence: true
  validates :is_active, presence: true



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
