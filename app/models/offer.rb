class Offer < ActiveRecord::Base
	after_initialize :init

	scope :within_range, lambda { where("created_at <= ?", Date.today + 30) }
	# Validations
	validates :service_start_date, presence: true 
	validates :service_finish_date, presence: true 
	validates :offer_start_date, presence: true 
	validates :offer_finish_date, presence: true
	# relationship
	has_many :users, :through => :offer_users
	has_many :offer_users, :dependent => :destroy
	has_many :comments
	# default for will_paginate
  	self.per_page = 10

  	def init
		self.status  ||= 1
	end

	# search dates

	ransacker :service_start_date do
  	Arel::Nodes::SqlLiteral.new("date(offers.service_start_date)")
	end

	ransacker :service_finish_date do
  	Arel::Nodes::SqlLiteral.new("date(offers.service_finish_date)")
	end

	ransacker :offer_finish_date do
  	Arel::Nodes::SqlLiteral.new("date(offers.offer_finish_date)")
	end

	ransacker :offer_start_date do
  	Arel::Nodes::SqlLiteral.new("date(offers.offer_start_date)")
	end

	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |offer|
        csv << offer.attributes.values_at(*column_names)
      end
    end
  end
end