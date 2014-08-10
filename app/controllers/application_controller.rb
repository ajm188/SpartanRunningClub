class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize

  hide_action :authorize_as_officer

  def authorize_as_officer
    unless signed_in? && current_user.officer
      deny_access 'You must have admin rights to view that resource.'
    end
  end
end
