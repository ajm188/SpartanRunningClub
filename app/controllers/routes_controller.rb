class RoutesController < ApplicationController
	before_filter :authorize_as_officer, except: [:index, :show]

	before_action :set_route, only: [:show, :edit, :update, :destroy]
	before_action :parse_map_my_run_id, only: [:create, :update]
	
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

	def edit_all
		@routes = Route.all
	end

	private

	def route_params
		params.require(:route).permit :title, :distance, :map_my_run_id
	end

	def set_route
		@route = Route.find(params[:id]) if params[:id]
	end

	def parse_map_my_run_id
		mmr_id = params[:route][:map_my_run_id] || nil
		return unless mmr_id

		return if mmr_id =~ /\A[0-9]*\Z/ # we're good if it's already all numbers

		match = mmr_id.match /\A.*views\/([0-9]*).*\Z/
		real_id = match ? match.captures.first : nil
		params[:route][:map_my_run_id] = real_id
	end
end
