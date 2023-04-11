require 'rails_helper'

RSpec.describe UsersController, type: :request do
  before do
    @first_user = User.create(
      name: 'Tom',
      photo: 'https://cdn3.iconfinder.com/data/icons/avatars-flat/33/man_5-512.png',
      bio: 'Teacher from Mexico.',
      posts_counter: 0
    )
    @second_user = User.create(
      name: 'Lilly',
      photo: 'https://cdn1.iconfinder.com/data/icons/user-pictures/100/female1-512.png',
      bio: 'Teacher from Poland.',
      posts_counter: 0
    )
    @post = Post.create(
      author: @first_user,
      title: 'Hello2',
      text: 'This is my 2 post',
      comments_counter: 0,
      likes_counter: 0
    )
  end
  describe 'GET #index' do
    before do
      get user_posts_path(@first_user)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'displays the correct template and content' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before do
      get user_post_path(@first_user, @post)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'displays the correct template' do
      expect(response).to render_template(:show)
    end

    it 'displays the correct content' do
      expect(response.body).to include(@post.title.to_s)
    end
  end
end
