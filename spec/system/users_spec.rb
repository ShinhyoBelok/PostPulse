require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
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
    @post1 = Post.create(
      author: @first_user,
      title: 'Hello2', 
      text: 'This is my 2 post',
      comments_counter: 0,
      likes_counter: 0
    )
    Post.create(author: @first_user, title: 'Hello3', text: 'This is my 3 post', comments_counter: 0, likes_counter: 0)
    Post.create(author: @first_user, title: 'Hello4', text: 'This is my 4 post', comments_counter: 0, likes_counter: 0)
    Post.create(author: @second_user, title: 'Hello5', text: 'This is my 5 post', comments_counter: 0, likes_counter: 0)
    Post.create(author: @second_user, title: 'Hello6', text: 'This is my 6 post', comments_counter: 0, likes_counter: 0)
    @user1_url = "#{users_path}/#{@first_user.id}"
    @user2_url = "#{users_path}/#{@second_user.id}"
  end

  describe 'Index' do
    before do
      visit users_path
    end
    scenario 'User sees list of all other users' do
      expect(page).to have_content(@first_user.name)
      expect(page).to have_content(@second_user.name)
      visit @user1_url
      expect(page).to have_content(@first_user.name)
      visit @user2_url
      expect(page).to have_content(@second_user.name)
    end

    scenario 'User sees profile picture for each user' do
      expect(page).to have_css("img[src*='#{@first_user.photo}']")
      expect(page).to have_css("img[src*='#{@second_user.photo}']")
      visit @user1_url
      expect(page).to have_css("img[src*='#{@first_user.photo}']")
      visit @user2_url
      expect(page).to have_css("img[src*='#{@second_user.photo}']")
    end

    scenario 'User sees number of posts each user has written' do
      visit @user1_url
      expect(page).to have_content('Number of post: 3')
      visit @user2_url
      expect(page).to have_content('Number of post: 2')
    end

    scenario 'User can click on a user and be redirected to their show page' do
      click_link @first_user.name
      expect(current_path).to eq(@user1_url)
      visit users_path
      click_link @second_user.name
      expect(current_path).to eq(@user2_url)
    end
  end

  describe 'Show' do
    before do
      visit user_path(@first_user)
    end

    scenario "User can see the user's profile picture" do
      expect(page).to have_css("img[src*='#{@first_user.photo}']")
    end

    scenario "User can see the user's username" do
      expect(page).to have_content(@first_user.name)
    end

    scenario 'User can see the number of posts the user has written' do
      expect(page).to have_content('Number of post: 3')
    end

    scenario "User can see the user's bio" do
      expect(page).to have_content(@first_user.bio)
    end

    scenario "User can see the user's first 3 posts" do
      @first_user.most_recent_posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
      end
    end

    scenario "User can see a button that lets me view all of a user's posts" do
      expect(page).to have_link('See all Post')
    end

    scenario "When user click a user's post, it redirects me to that post's show page" do
      click_link @post1.title
      expect(current_path) == "#{@user1_url}/posts/#{@post1.id}"
    end

    scenario "When user click to see all posts, it redirects me to the user's post's index page" do
      click_link 'See all Post'
      expect(current_path) == "#{@user1_url}/posts"
    end
  end
end
