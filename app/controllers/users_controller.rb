class UsersController < ApplicationController
		before_filter :authenticate_user!
  	before_action :set_user, only: [:show, :edit, :destroy]
	
		# GET /products
		# GET /products.json
		def index
			if params[:q]
				@search = User.ransack(params[:q])
				@users = @search.result.page(params[:page])
			else
				@search = User.ransack(params[:q])
				@users = User.where('users.rol != ?', 'admin').page(params[:page])
			end
			respond_to do |format|
				format.html
				format.js
			end
		end

		def new
		 	@provider = User.new()
		end
		
		# POST /products
	  # POST /products.json
	  def create_user
	  	o = [('a'..'z'), ('1'..'9')].map { |i| i.to_a }.flatten
	  	string = (0...9).map { o[rand(o.length)] }.join
	  	@user = User.create( username: params[:user][:username],password: string ,rol: params[:user][:rol], name: params[:user][:name], carrier: params[:user][:carrier], email: params[:user][:email], landline: params[:user][:landline], cell_phone: params[:user][:cell_phone], container: params[:user][:cell_phone], liquid_charge: params[:user][:liquid_charge], dry_charge: params[:user][:dry_charge] )
	  	respond_to do |format|
	  		if @user.save
	  			flash[:notice] = 'Se ha creado un nuevo usuario'
	  			format.html { redirect_to users_path }
	  			format.js   {}
	  			format.json { render :show, status: :created, location: @user }
	  		else
	  			warden.custom_failure!
	  			format.html { render :new }
	  			format.json { render json: @user.errors, status: :unprocessable_entity }
	  		end
	  	end
	  end

		def show
		end
		
		def destroy
			@user = User.find(params[:id])
			@user.destroy
			flash[:notice] = 'El Usuario ha sido eliminado'
			redirect_to users_url
		end
		
		private
		# Use callbacks to share common setup or constraints between actions.
		def set_user
			@user = User.find(params[:id])
		end

end
