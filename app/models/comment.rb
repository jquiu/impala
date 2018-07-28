class Comment < ActiveRecord::Base
	after_initialize :init
	# relation
	belongs_to :user
	belongs_to :offer
	
	def init
		self.status  ||= 1
	end
	
	# default for will_paginate
  	self.per_page = 10
end

