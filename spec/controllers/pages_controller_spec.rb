require 'spec_helper'

describe PagesController do
  render_views

  describe "GET '/'" do
    it "is successful" do
      get :index
      response.should be_success
    end

    it "is the API Documentation" do
      get :index
      response.body.should =~ /Paul Simpson API/
    end
  end
end
