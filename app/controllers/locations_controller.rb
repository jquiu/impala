class LocationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @search = Location.ransack(params[:q])
    @locations = @search.result.page(params[:page])
    @location = Location.new()
    respond_to do |format|
      format.html
      format.js
    end
  end


  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        flash[:notice] = 'La Ubicación ha sido actualizado'
        format.html { redirect_to @location}
        format.json { render :show, status: :created, location: @location }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

 # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        flash[:notice] = 'La Ubicación ha sido actualizado'
        format.html { redirect_to @location }
        format.json { render :show, status: :ok, location: @location }
        format.js   { js_redirect_to(locations_path)}
      else
        format.html { render :edit }
        format.js   {}
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      flash[:notice] = 'Se ha eliminado exitosamente'
      format.html { redirect_to locations_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:location)
    end
end
