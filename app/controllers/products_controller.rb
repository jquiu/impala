class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @search = Product.ransack(params[:q])
    @products = @search.result.page(params[:page])
    @product = Product.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Se ha creado su nuevo producto'
        format.html { redirect_to @product }
        format.js   {}
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.js   {}
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Offers/1
  # PATCH/PUT /Offers/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        flash[:notice] = 'La producto ha sido actualizado'
        format.html { redirect_to @product }
        format.json { render :show, status: :ok, location: @product }
        format.js   { js_redirect_to(products_path)}
      else
        format.html { render :edit }
        format.js   {}
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = 'El producto ha sido eliminado'
    redirect_to products_url
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :ref)
    end
end
