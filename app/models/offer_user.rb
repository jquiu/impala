class OfferUser < ActiveRecord::Base
	after_initialize :init
	# scope
	scope :search_offer, ->(id) {where offer_id: id}
	# validates
	validates :price, presence: true 
	validates :quantity, presence: true 
	# relations
	belongs_to :offer
	belongs_to :user
	
	def init
		self.status  ||= true		
	end

end

