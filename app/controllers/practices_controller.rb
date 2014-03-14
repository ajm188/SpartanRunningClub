class PracticesController < ApplicationController
	before_action :set_practice, only: [:edit, :update, :destroy]

	def index
		@sundays = Practice.sunday.ordered
		@mondays = Practice.monday.ordered
		@tuesdays = Practice.tuesday.ordered
		@wednesdays = Practice.wednesday.ordered
		@thursdays = Practice.thursday.ordered
		@fridays = Practice.friday.ordered
		@saturdays = Practice.saturday.ordered
	end

	def admin_edit
		@practices = Practice.sunday.ordered
		@practices = @practices.concat Practice.monday.ordered
		@practices = @practices.concat Practice.tuesday.ordered
		@practices = @practices.concat Practice.wednesday.ordered
		@practices = @practices.concat Practice.thursday.ordered
		@practices = @practices.concat Practice.friday.ordered
		@practices = @practices.concat Practice.saturday.ordered
	end

	def new
		@practice = Practice.new
	end

	def create
		@practice = Practice.new practice_params
		if @practice.save
			redirect_to practice_edit_path
		else
			render action: 'new'
		end
	end

	def edit
	end

	def destroy
		@practice.destroy
		redirect_to practice_edit_path
	end

	private
		def practice_params
			params.require(:practice).permit(:day, :hour, :minute, :am_pm)
		end

		def set_practice
			@practice = Practice.find params[:id] if params[:id]
		end
end