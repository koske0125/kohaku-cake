class Customer < ApplicationRecord
  has_many :addresses
  has_many :cart_items
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 validates :first_name, :last_name, :first_name_kana, :last_name_kana,
            :address, :telephone_number, :postal_code,
            presence: true
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  validates :telephone_number, numericality: { only_integer: true }
  validates :first_name_kana, :last_name_kana,
      format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "カタカナで入力して下さい。"}

  def active_for_authentication?
    super && (is_deleted == false)
  end

end
