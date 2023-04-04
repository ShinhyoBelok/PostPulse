require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(200)
    end

    it 'displays the correct template' do
      get '/users/:user_id/posts'
      expect(response).to render_template(:index)
    end

    it 'displays the correct content' do
      get '/users/123/posts'
      expect(response.body).to include('Show a list of all related posts of user 123')
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(200)
    end

    it 'displays the correct template' do
      get '/users/:user_id/posts/:id'
      expect(response).to render_template(:show)
    end

    it 'displays the correct content' do
      get '/users/3/posts/44'
      expect(response.body).to include('Show a post with id 44 of user 3')
    end
  end
end
