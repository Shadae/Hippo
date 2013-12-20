class CategoriesController < ApplicationController
  def new
    require_login
    @category = Category.new
    #@product = Product.find(params[:product_id]) 
  end

  def create
    @product = Product.find(params[:product_id])
    @category = Category.new(category_params)
    # @categories = Category.all
    if @category.save
      CategoryProduct.create(product_id:params[:product_id], category_id:@category.id)
      redirect_to edit_product_path(params[:product_id])
    #redirect_to product_path(@product.id) 
    #needs some way to remember which product 
    #you were editing at the time you wanted to create this new category
    else
      flash[:notice] = "This category already exists!"
      redirect_to new_category_path(@product)
    end
  end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
