class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { production_prohibition: 0, waiting_for_production: 1, making: 2, maked: 3 }
end
