class RoastersController < ApplicationController
	before_action :load_roaster, only: [:edit, :show, :update, :destroy]

	def index
		@roasters = Roaster.all
	end

	def edit
		@shops = Shop.all
	end

	def show
	end

	def new
		@shops = Shop.all
		@roaster = Roaster.new
	end

	def create
		@roaster = Roaster.new(safe_roaster_params)
		if @roaster.save
			redirect_to @roaster
		else
			render 'new'
		end
	end

	def update
		if @roaster.update(safe_roaster_params)
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