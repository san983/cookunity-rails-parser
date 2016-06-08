require 'rails_helper'

RSpec.describe StatusController, type: :controller do
  describe "GET #show" do
    it "returns the current migration version" do
      allow(ActiveRecord::Migrator).to receive_messages(current_version: "2016xxxx")
      get :show

      expect(response).to have_http_status(:success)
      expect(response.body).to eq("2016xxxx")
    end
  end
end
