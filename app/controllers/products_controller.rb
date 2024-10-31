class ProductsController < ApplicationController

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    if @product.image.attached?
      @product.image.attach(params[:product][:image])
    else
      @product.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), 
                        filename: 'default.png', 
                        content_type: 'image/png')
    end

    if @product.save
      flash[:success] = "登録に成功しました"
      redirect_to :products, id: @product.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    @user = User.find(current_user.id)
  end

  def index
    @products = Product.where('address LIKE(?)',"%#{params[:address]}%")
   if params[:keyword].present?
     @products = Product.where([ 'content LIKE ? OR name LIKE ? ',"%#{params[:keyword]}%","%#{params[:keyword]}%" ])
   end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.user_id = current_user.id

    if @product.update(product_params)
      flash[:success] = "保存しました。"
      redirect_to :products, id: @product.id
    else
      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "削除しました"
    redirect_to :products
  end

  private
    def product_params
      params.require(:product).permit(:name, :content, :amount, :address, :image)
    end
end
