class MemberMeetingsController < ApplicationController
  before_filter :authorize_as_officer
  
  def new
  end
end
