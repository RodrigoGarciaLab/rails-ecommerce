class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.paginate(page: params[:page], per_page: 10)
    @order_item = current_order.order_items.new
    render :layout => 'admin_layout'
  end

  def index_category
    if params[:category_id] < 1
      @products = Product.all
    else
      @category = Category.find(params[:category_id])
      @products = Product.where(category_id: @category.id).paginate(page: params[:page], per_page: 9)
    end
    @order_item = current_order.order_items.new
  end
  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new 
    @product = Product.new 
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all.map{|c| [ c.name, c.id ] }
    render :layout => 'admin_layout'
  end

  # POST /products
  # POST /products.json
  def create 
    @product = Product.new(product_params) 
    @product.category_id = params[:category_id] 
    respond_to do |format| 
      if @product.save 
        format.html { redirect_to @product, notice: 'Product was successfully created.'} 
        format.json { render :show, status: :created, location: @product } 
      else 
        format.html { render :new } 
        format.json { render json: @product.errors, status: :unprocessable_entity } 
      end 
    end 
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product.category_id = params[:category_id]
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_products_url, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :category_id, :picture)
    end
end
