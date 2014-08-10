require 'rails_helper'

RSpec.describe "Meetings", :type => :request do
  describe "GET /meetings" do
    it "works! (now write some real specs)" do
      get meetings_path
      expect(response.status).to be(200)
    end
  end
end
