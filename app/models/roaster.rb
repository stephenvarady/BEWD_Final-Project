class Roaster < ActiveRecord::Base
	has_many :accounts
	has_many :shops, :through => :accounts
end
