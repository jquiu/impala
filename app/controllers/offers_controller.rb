class OffersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

 # GET /Offers
  # GET /Offers.json
  def index
    @offer = Offer.new()
    @product = Product.new()
    @location = Location.new()
    @measure = Measure.new()
    
    if current_user.rol == "admin" or current_user.rol == "supervicer" 
      @search = Offer.within_range.ransack(params[:q])
      @offers = @search.result.order(created_at: :desc).page(params[:page])
    elsif current_user.rol == "providers"
      @search = Offer.ransack(params[:q])
      @offers = Offer.where('offers.status = ?', '1').order(created_at: :desc).page(params[:page])
    end
    respond_to do |format|
        format.html
        format.js
        format.csv { send_data @offers.to_csv }
        format.xls { send_data @offers.to_csv(col_sep: "\t") }
    end
  end

  # GET /Offers/1
  # GET /Offers/1.json
  def show
    @comment = Comment.new
    @search = OfferUser.search_offer(params[:id]).ransack(params[:q])
    if params[:q]
      @offer_users = @search.result.order(price: :desc).page(params[:page])
    else
      @offer_users = OfferUser.where(offer_id: params[:id]).order(price: :desc).page(params[:page]) 
    end
    @offer_user = OfferUser.find_by_offer_id_and_user_id(params[:id], current_user.id)
  end

  def download
    @offer_users = OfferUser.where(offer_id: params[:offer_id]).order(price: :desc).page(params[:page]) 
    respond_to do |format|
      format.html
      format.xls { send_data @offer_users.to_csv(col_sep: "\t") }
    end
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        flash[:notice] = 'Se ha creado su nueva oferta'
        format.html { redirect_to @offer }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        flash[:notice] = 'Se ha modificado su oferta'
        format.html { redirect_to @offer }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_status 
    @offer = Offer.find(params[:id]) 
    val = @offer.status == 1 ? 2 : 1 
    @offer.update_attribute(:status, val)  
    respond_to do |format|
      if @offer.status == 1
        format.html { redirect_to @offer, notice: 'Se ha Activado su oferta' }
      else @offer.status == 2
        format.html { redirect_to @offer, notice: 'Se ha Desactivado su oferta' }
      end
    end    
  end

  def extend
    @offer = Offer.find(params[:id])
    service_finish_date = params[:offer][:service_finish_date]
    offer_finish_date = params[:offer][:offer_finish_date]
    respond_to do |format|
      if @offer.update(:service_finish_date => service_finish_date , :offer_finish_date => offer_finish_date)
        format.html { redirect_to @offer, notice: 'Se ha extendido su oferta' }
      end
    end  
  end

  # POST /Offer_User
  # POST /Offer_User.json
  def create_offer_user
    if OfferUser.exists?(offer_id: params[:offer_user][:offer_id], user_id: params[:offer_user][:user_id])
       @offer_user = OfferUser.find_by_offer_id_and_user_id(params[:offer_user][:offer_id],params[:offer_user][:user_id])
       @offer_user.update(quantity: params[:offer_user][:quantity], price: params[:offer_user][:price])
    else
      @offer_user = OfferUser.new(quantity: params[:offer_user][:quantity], price: params[:offer_user][:price], offer_id: params[:offer_user][:offer_id], user_id: params[:offer_user][:user_id])
    end
    respond_to do |format|
      if @offer_user.save
        flash[:notice] = 'Su oferta ha sido creada exitosamente'
        format.html { redirect_to root_path}
        format.js   {}
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
        format.js   {}
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Su oferta ha sido eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:product, :origins, :destination, :volumen, :price, :container, :general_load, :liquid_load, :load_compensation, :offert_type, :unit, :observation, :status, :service_start_date, :offer_finish_date, :offer_start_date, :service_finish_date)
    end
end
