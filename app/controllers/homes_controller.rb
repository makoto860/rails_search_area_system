class HomesController < ApplicationController
  def home
  end

  def tokyo
    @products = Product.where('address LIKE ?', "%東京%")
  end

  def hakodate
    @products = Product.where('address LIKE ?', "%函館%")
  end

  def osaka
    @products = Product.where('address LIKE ?', "%大阪%")
  end

  def nagoya
    @products = Product.where('address LIKE ?', "%名古屋%")
  end
end
