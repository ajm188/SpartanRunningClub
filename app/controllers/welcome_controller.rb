class WelcomeController < ApplicationController
  skip_before_filter :authorize, only: [:home, :contact, :about]

  def home
    @active = CarouselItem.first_index
    @items = CarouselItem.rest
    @upcoming_events = Event.upcoming.limit(5)
  end

  def contact
    @officers = Member.officers
  end

  def about
  end

  def feedback
  end

  def submit_feedback
    if params[:feedback].blank?
      flash[:error] = 'Please enter some feedback.'
      render action: :feedback
    else
      flash[:notice] = "Thanks for your feedback! We'll look into it."
      Mailer.feedback(params[:feedback], current_user).deliver
      redirect_to root_path
    end
  end

  def orgsync
  end
end
