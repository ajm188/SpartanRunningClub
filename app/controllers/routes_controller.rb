class RoutesController < ApplicationController
	before_filter :authorize_as_officer, except: [:index, :show]

	before_action :set_route, only: [:show, :edit, :update, :destroy]
	
	def index
		@routes = Route.all
	end

	def show
	end

	def new
		@route = Route.new
	end

	def create
		@route = Route.new route_params
		if @route.save
			redirect_to edit_routes_path
		else
			render action: 'new'
		end
	end

	def edit
	end

	def update
		if @route.update route_params
			redirect_to edit_routes_path, notice: 'Route was successfully updated'
		else
			render action: 'edit'
		end
	end

	def destroy
		@route.destroy
		redirect_to edit_routes_path
	end

	def edit_routes
		@routes = Route.all
	end

	private
		def route_params
			params.require(:route).permit :title, :distance, :map_image
		end

		def set_route
			@route = Route.find(params[:id]) if params[:id]
		end
end
