require 'swagger_helper'

describe 'Cancel Meal API' do

  let(:cancel_meal) {}

  let(:invalid_auth_token) do
    ActionController::HttpAuthentication::Token.encode_credentials('invalid-token')
  end

  let(:valid_auth_token) do
    ActionController::HttpAuthentication::Token.encode_credentials(Rails.application.secrets.api_token)
  end

  let(:Authorization) { valid_auth_token }

  path '/api/v1/cancel_meals' do
    post 'Creates a cancel meal job'  do
      # tags 'Blogs'
      security [ Token: [] ]
      consumes 'application/json'
      parameter name: :cancel_meal, in: :body, schema: {
        type: :object,
        properties: {
          meal: { type: :string }
        },
        required: [ 'cancel_meal' ]
      }

      response '201', 'Cancel meal job created' do
        let(:cancel_meal) { { meal: "Soup from #{DateTime.now}" } }
        run_test!
      end

      response '400', 'Bad Request' do
        let(:'Content-Type') { 'application/xml' }
        run_test!
      end

      response '401', 'Invalid Token' do
        let(:Authorization) { invalid_auth_token }
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end
end
