class OrderProduct < ApplicationRecord

  before_save :unit_price_save

  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true,  numericality: { only_integer: true, greater_than: 0 }
  

  private

  def unit_price_save
    self[:unit_price] = product.price
  end
end
