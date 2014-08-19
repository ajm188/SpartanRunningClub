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

  def logarun
  end

  def spartan_link
  end
end
