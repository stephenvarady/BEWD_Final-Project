class RoastersController < ApplicationController
	before_action :load_roaster, only: [:edit, :show, :update, :destroy]

	def index
		@shops = Shop.all
		@roasters = Roaster.all
		@location = request.location
		@hash = Gmaps4rails.build_markers(@shops) do |shop, marker|
		  marker.lat shop.latitude
		  marker.lng shop.longitude
		end
	end

	def edit
		@shops = Shop.all
	end

	def show
		@accounts = Account.all
		@shops = Shop.all

		# Looks through all accounts, if roaster_id matches 
		# the current roaster page, returns array of shop names.
		# @shop_list = @accounts.map do |account|
		# 	if account.roaster_id === @roaster.id
		# 		account.shop.name
		# 	end
		# end

		@shop_list = @accounts.select { |account| account.roaster_id == @roaster.id }
		@shop_names = @shop_list.map { |account| account.shop.name if account.shop != nil }

		@hash = Gmaps4rails.build_markers(@shops) do |shop, marker|
		  marker.lat shop.latitude
		  marker.lng shop.longitude
		end

	end

	def new
		@shops = Shop.all
		@roaster = Roaster.new
	end

	def create
		@roaster = Roaster.new(safe_roaster_params)
		if @roaster.save
			##
			redirect_to @roaster
		else
			render 'new'
		end
	end

	def update
		if @roaster.update(safe_roaster_params)

			# Collects checked boxes from form (array of IDs)
			 accounts = params[:roaster][:shop_ids] ||= []
			 shops_with_account = accounts.collect
			# Saves roaster_id and shop_id to join model
			shops_with_account.map do |shop|
				account = Account.new(:roaster_id => @roaster.id,:shop_id => shop)
				if account.valid?
					account.save!
				end
			end

			redirect_to @roaster
		else
			render 'edit'
		end
	end

	def destroy
		@roaster.destroy
		redirect_to roasters_url
	end

	private

	def safe_roaster_params
		params.require("roaster").permit(:name)
	end

	def load_roaster
   		@roaster = Roaster.find(params[:id])
  		rescue ActiveRecord::RecordNotFound
    	flash.now[:notice] = "Invalid Roaster ID #{params[:id]}"
    	redirect_to root_path
  	end

end