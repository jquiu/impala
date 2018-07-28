class Measure < ActiveRecord::Base
	# validates
	validates :unit, presence: true 
	validates_uniqueness_of :unit

	self.per_page = 10
end
