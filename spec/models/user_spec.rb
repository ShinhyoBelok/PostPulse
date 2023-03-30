require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Jinx', photo: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.artstation.com%2Fartwork%2F3qxGKg&psig=AOvVaw2ppN_YJudS2unidOQjC_W6&ust=1680299062295000&source=images&cd=vfe&ved=0CBAQjRxqGAoTCIjs8PbPhP4CFQAAAAAdAAAAABCBAQ',
             bio: 'Pistoler',
             posts_counter: 0)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Posts_counter should be greater than or equal to zero' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Should bring the 3 most recents posts' do
    subject.posts.create(author: subject, title: 'Posting1', text: 'test post1', comments_counter: 0,
                         likes_counter: 0)
    subject.posts.create(author: subject, title: 'Posting2', text: 'test post2', comments_counter: 0,
                         likes_counter: 0)
    subject.posts.create(author: subject, title: 'Posting3', text: 'test post3', comments_counter: 0,
                         likes_counter: 0)
    subject.posts.create(author: subject, title: 'Posting4', text: 'test post4', comments_counter: 0,
                         likes_counter: 0)
    subject.posts.create(author: subject, title: 'Posting5', text: 'test post5', comments_counter: 0,
                         likes_counter: 0)
    subject.posts.create(author: subject, title: 'Posting6', text: 'test post6', comments_counter: 0,
                         likes_counter: 0)

    most_recent_posts = subject.most_recent_posts

    most_recent_posts.each_with_index do |post, i|
      expect(post.id) == subject.posts.count - i
    end
  end
end
