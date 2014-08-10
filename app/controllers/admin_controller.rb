class AdminController < ApplicationController
  before_filter :authorize_as_officer
  
	def panel
	end
end
