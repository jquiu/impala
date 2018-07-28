class Location < ActiveRecord::Base
	# validates
	validates :location, presence: true 
	validates_uniqueness_of :location

	self.per_page = 10
end
