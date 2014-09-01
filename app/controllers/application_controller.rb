class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize

  hide_action :authorize_as_officer, :authorize_as_officer_or_self

  def authorize_as_officer
    unless signed_in? && current_user.officer
      deny_access 'You must have admin rights to view that resource.'
    end
  end

  def authorize_as_officer_or_self
    unless signed_in? &&
      (current_user.officer || current_user.id == params[:id].to_i)
      deny_access 'You do not have the appropriate permissions to do that.'
    end
  end
end
