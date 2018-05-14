module Api::V1
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate

    rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
      render text: "Required parameter missing: #{parameter_missing_exception.param}", status: :bad_request
    end

    protected

    # Authenticate the user with token based authentication
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, _options|
        token == Rails.application.secrets.api_token
      end
    end

    def render_unauthorized(realm = "Application")
      self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
      render json: 'Bad credentials', status: :unauthorized
    end
  end
end
