class Roaster < ActiveRecord::Base
	has_many :accounts
	has_many :shops, :through => :accounts

	def relationship(rId, sId)
		test = Account.where(:roaster_id => rId, :shop_id => sId).count
		if test == 0 
			false
		else
			true
		end
	end
end
