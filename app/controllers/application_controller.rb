class ApplicationController < ActionController::API
  include ActionController::Serialization

  protected

  def render_not_found
    render plain: '', status: :not_found
  end
end
