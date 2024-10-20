class ProductsController < ApplicationController
  def index
    if params[:keyword].present?
      @products = Product.search(params[:keyword])
    else
      @products = Product.all
    end
  end

  def search
    redirect_to products_path(keyword: params[:keyword])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    if @product.image.attached?
      @product.image.attach(params[:product][:image])
    else
      @product.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), 
                        filename: 'default.png', 
                        content_type: 'image/png')
    end

    if @product.save
      flash[:success] = "productを新規登録しました"
      redirect_to :products, id: @product.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    @user = User.find(current_user.id)
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.user_id = current_user.id

    if @product.update(product_params)
      flash[:success] = "PRODUCT IDが「#{@product.id}」の情報を更新しました。"
      redirect_to :products, id: @product.id
    else
      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "productを削除しました"
    redirect_to :products
  end

  private
    def product_params
      params.require(:product).permit(:name, :content, :amount, :address, :image, :user_id)
    end
end
