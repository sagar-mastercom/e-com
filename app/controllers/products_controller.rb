class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /products
  def index
    @products = Product.all

    # Apply filters based on request parameters
    # if params[:cat_name].present?
    #   @products = Product.joins(:product_category).where(product_categories: { cat_name: params[:cat_name] })
    #   puts "#{params[:cat_name]} : product category"
    #   puts "Products:  #{@products}"
    # end

    if params[:min_price].present? && params[:max_price].present?
      @products = @products.where(price: params[:min_price]..params[:max_price])
    elsif params[:min_price].present?
      @products = @products.where('price >= ?', params[:min_price])
    elsif params[:max_price].present?
      @products = @products.where('price <= ?', params[:max_price])
    end

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    # AsyncJob.perform_async
    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price)
    end
end
