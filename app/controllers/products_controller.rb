class ProductsController < ApplicationController

  # def index
  #   @products = Product.all
  #   render partial: "index"
  # end

  def show
    @product = Product.find(params[:id])
  end

  def new
    if current_user
      @product = Product.new #(user_id: params[:user_id])
      render :new
    else
      redirect_to sign_in_path, notice: "You must sign in to list a product!"
    end
  end

  def edit   
    @product = Product.find(params[:id]) 
  end


  def create #If @product save, else render edit
    @product = Product.new(product_params)
    @product[:user_id] = current_user.id
    if @product.save
      redirect_to "/products/#{@product.id}", notice: "You have successfully listed this product!"
    else
      redirect_to "/products/new", notice: "There was an error, try again."
    end
  end

  def update
    @product = Product.find(params[:id])
    #Instead of Params block productcategory.new(productcategory params private method)
    #Private method product catagory Params params.require.productcategory.permit(product_id, category_id)
    
    # @category_product.new(category_product_params).save
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])  
    @product.destroy
    redirect_to products_path  
  end

  def search_by_name
     @products = Product.where name: params[:product] 
  end
end

private

def product_params
  params.require(:product).permit(:name, :price, :user_id, :inventory, :description, :retired)
end

# def category_product_params
#   params.require(:category_product).permit(:product_id, :category_id)
# end

