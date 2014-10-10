class Shop < ActiveRecord::Base
	has_many :accounts
	has_many :roasters, :through => :accounts

	geocoded_by :address
	after_validation :geocode

	def address
		[street, city, state, country].compact.join(', ')
	end

end
