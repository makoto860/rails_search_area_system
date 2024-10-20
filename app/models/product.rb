class Product < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_one_attached :image

  def self.search(search)
    if search.present?
      Product.where(['name LIKE(?) OR content LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      Product.includes(:product).order('created_at DESC')
    end
  end

  validates :name, presence: true
  validates :content, presence: true
  validates :amount, presence: true
  validates :address, presence: true
end
