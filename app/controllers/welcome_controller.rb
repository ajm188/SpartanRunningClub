class WelcomeController < ApplicationController
  def home
  	@active = CarouselItem.first_index
  	@items = CarouselItem.rest.in_order
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