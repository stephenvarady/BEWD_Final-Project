class ShopsController < ApplicationController
	before_action :load_shop, only: [:edit, :show, :update]

	def index
		@shops = Shop.all
		@user = current_user
	end

	def show
	end

	def new
		@shop = Shop.new
	end

	def create
		@shop = Shop.new(safe_shop_params)
		if @shop.save
			redirect_to @shop
		else
			render 'new'
		end
	end

	def update
		if @shop.update(safe_shop_params)
			redirect_to @shop
		else
			render 'edit'
		end
	end

	def edit
	end

	def delete
	end

	private

	def safe_shop_params
		params.require("shop").permit(:name, :street, :city, :state)
	end

	def load_shop
   		@shop = Shop.find(params[:id])
  		rescue ActiveRecord::RecordNotFound
    	flash.now[:notice] = "Invalid Shop ID #{params[:id]}"
    	redirect_to root_path
  	end

end
