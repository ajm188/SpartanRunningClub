require "rails_helper"

RSpec.describe CommentsController, :type => :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/comments/new").to route_to("comments#new")
    end

    it "routes to #create" do
      expect(:post => "/comments").to route_to("comments#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/comments/1").to route_to("comments#destroy", :id => "1")
    end

  end
end
