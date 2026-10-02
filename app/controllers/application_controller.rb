class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
  rescue_from ActionView::Template::Error, with: :rescue_template_error

  protected

  def rescue_not_found
    render json: {error: "Record could not be found" }, :status => 404
  end

  def rescue_template_error
    render json: {error: "An error occurred while processing your request" }, :status => 500
  end
end
