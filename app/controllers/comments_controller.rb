class CommentsController < ApplicationController
  def index
  	@comments = Comment.all.order('created_at desc').page(params[:page])
  end
  def show
  	@comment = Comment.find(params[:id])
  	@comment.update(:status => 2)
  end
  
  def create
    @comment = Comment.new(comments_params)
    respond_to do |format|
      if @comment.save
      	@offer = Offer.find(@comment.offer_id)
        flash[:notice] = 'Su mensaje ha sido enviado'
        format.html { redirect_to @offer}
        format.json { render :show, status: :created, location: @location }
        format.js {}
      else
      	flash[:notice] = 'Se ha producido un error'
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end
  
  def send_mail
    email = params[:email]
    body = params[:comments]
    @comment = Comment.find(params[:id])
    NotificationMailer.contact_email( email, body).deliver
    redirect_to @comment, notice: 'Envio de mensaje'
  end

  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def comments_params
      params.require(:comment).permit(:offer_id, :user_id, :description, :subject)
    end
end
