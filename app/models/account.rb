class Account < ActiveRecord::Base
	belongs_to :roaster
	belongs_to :shop

	validates_uniqueness_of :roaster_id, :scope => [:shop_id]
end
