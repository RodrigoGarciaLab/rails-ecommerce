class Product < ApplicationRecord
  mount_uploader :picture, PictureUploader
	belongs_to :category
  has_many :order_items
  validates :name,  presence: true, length: { maximum: 50 }
  validates :price,  presence: true
  validates :category_id,  presence: true
end
