require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def index
      render inline: "<% raise 'boom' %>"
    end

    def show
      User.find(params[:id])
    end
  end

  it "renders template errors as a JSON 500" do
    get :index
    expect(response).to have_http_status(:internal_server_error)
    expect(JSON.parse(response.body)).to eq("error" => "An error occurred while processing your request")
  end

  it "renders missing records as a JSON 404" do
    get :show, params: { id: 0 }
    expect(response).to have_http_status(:not_found)
    expect(JSON.parse(response.body)).to eq("error" => "Record could not be found")
  end
end
