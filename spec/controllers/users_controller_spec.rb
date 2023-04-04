require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET #index" do
    it "returns a successful response" do
      get "/users"
      expect(response).to have_http_status(200)
    end

    it "displays the correct template and content" do
      get "/users"
      expect(response.body).to include("List of user name and the number of posts")
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get "/users/:id"
      expect(response).to have_http_status(200)
    end

    it "displays the correct template and content" do
      get "/users/1"
      expect(response.body).to include("Show user information with the requested id 1")
    end
  end
end