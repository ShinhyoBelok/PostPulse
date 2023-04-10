require 'rails_helper'
RSpec.describe 'Posts', type: :system do
  before :each do
    driven_by(:rack_test)
    @user = User.create(
      name: 'Tornado',
      photo: 'https://unsplash.com/photos/Tornado',
      bio: 'Complete bio Tornado',
      posts_counter: 0
    )
    @post = Post.create(
      title: 'post 1',
      text: 'my last recent post',
      comments_counter: 0,
      likes_counter: 0,
      author: @user
    )
    Post.create(
      title: 'post 2',
      text: 'new post 2',
      comments_counter: 0,
      likes_counter: 0,
      author: @user
    )
    Post.create(
      title: 'post 3',
      text: 'new post 3',
      comments_counter: 0,
      likes_counter: 0,
      author: @user
    )
    Post.create(
      title: 'post 4',
      text: 'new post 4',
      comments_counter: 0,
      likes_counter: 0,
      author: @user
    )
    Post.create(
      title: 'post 5',
      text: 'new post 5',
      comments_counter: 0,
      likes_counter: 0,
      author: @user
    )
    Comment.create(author: @user, post: @post, text: 'comment 1')
    Comment.create(author: @user, post: @post, text: 'comment 2')
    Comment.create(author: @user, post: @post, text: 'comment 3')
    Comment.create(author: @user, post: @post, text: 'comment 4')
    Comment.create(author: @user, post: @post, text: 'comment 5')
    Comment.create(author: @user, post: @post, text: 'comment 6')
    @post1_url = "#{users_path}/#{@user.id}/posts/#{@post.id}"
  end

  describe 'Index' do
    before :each do
      visit user_posts_path(@user)
    end
    scenario 'I can see the first comments on a post.' do
      expect(page).to have_content('comment 6')
      expect(page).to have_content('comment 5')
      expect(page).to have_content('comment 4')
      expect(page).to have_content('comment 3')
      expect(page).to have_content('comment 2')
      expect(page).not_to have_content('comment 1')
    end
    scenario 'I can see the users profile picture.' do
      expect(page).to have_selector('img')
    end
    scenario 'I can see the users username.' do
      expect(page).to have_content('Tornado')
    end
    scenario 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of post: 5')
    end
    scenario 'I can see a posts title' do
      expect(page).to have_content('post 1')
    end
    scenario 'I can see some of the posts body.' do
      expect(page).to have_content('new post 4')
    end
    scenario 'I can see how many comments a post has.' do
      all('#comment-count') do |count|
        expect(count.text).to eq('Comments: 6')
      end
    end
    scenario 'I can see how many likes a post has.' do
      all('#comment-count') do |count|
        expect(count.text).to eq('Like: 0')
      end
    end
    scenario 'I can see a section for pagination if there are more posts than fit on the view.' do
      all('#comment-count') do |count|
        expect(count.text).to eq('Pagination')
      end
    end
    scenario 'when I click on Add posts button It should display the post form' do
      click_link 'New Post'
      expect(current_path) == new_user_post_path(@user)
    end
    scenario 'When I click on a post, it redirects me to that posts show page.' do
      click_link 'post 1'
      expect(current_path) == @post1_url
    end
  end

  describe 'Show' do
    before :each do
      visit user_post_path(@user, @post)
    end

    scenario 'User can see the first comments on a post' do
      expect(page).to have_content('comment 6')
      expect(page).to have_content('comment 5')
      expect(page).to have_content('comment 4')
      expect(page).to have_content('comment 3')
      expect(page).to have_content('comment 2')
      expect(page).to have_content('comment 1')
    end

    scenario 'User can see the post title' do
      expect(page).to have_content(@post.title)
    end

    scenario 'User can see who wrote the post' do
      expect(page).to have_content(@post.author.name)
    end

    scenario 'User can see how many comments it has' do
      expect(page).to have_content("Comments: 6")
    end

    scenario 'User can see how many likes it has' do
      expect(page).to have_content("Likes: 0")
    end

    scenario 'User can see the post body' do
      expect(page).to have_content(@post.text)
    end

    scenario 'User can see the username of each commentor' do
      @post.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    scenario 'User can see the comment each commentor left' do
      @post.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
