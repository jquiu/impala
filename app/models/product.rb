class Product < ActiveRecord::Base
	# Validations
	validates :name, presence: true 
	validates :ref, presence: true 

	self.per_page = 10
end
