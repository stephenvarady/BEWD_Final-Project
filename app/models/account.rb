class Account < ActiveRecord::Base
	belongs_to :roaster
	belongs_to :shop
end
