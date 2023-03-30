require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'jinx', photo: 'link', bio: 'player', posts_counter: 0)
  subject do
    Post.new(author: user, title: 'Vacation', text: 'Bluest beach on hawai!', comments_counter: 0, likes_counter: 0)
  end

  before { subject.save }

  def create_comments(subject, user)
    subject.comments.create(text: 'nice view1', author: user, post: subject)
    subject.comments.create(text: 'nice view2', author: user, post: subject)
    subject.comments.create(text: 'nice view3', author: user, post: subject)
    subject.comments.create(text: 'nice view4', author: user, post: subject)
    subject.comments.create(text: 'nice view5', author: user, post: subject)
    subject.comments.create(text: 'nice view6', author: user, post: subject)
    subject.comments.create(text: 'nice view7', author: user, post: subject)
  end

  def create_likes(subject, user)
    subject.likes.create(author: user, post: subject)
    subject.likes.create(author: user, post: subject)
    subject.likes.create(author: user, post: subject)
    subject.likes.create(author: user, post: subject)
  end

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be less than 250 chars' do
    # rubocop:disable Metrics/LineLength
    subject.title = 'The quick brown fox jumps over the lazy dog. Sphinx of black quartz, judge my vow. Jackdaws love my big sphinx of quartz. Pack my box with five dozen liquor jugs. How vexingly quick daft zebras jump! The five boxing wizards jump quickly. Waltz, nymph, for quick jigs vex Bud.'
    # rubocop:enable Metrics/LineLength
    expect(subject).to_not be_valid
    subject.title = 'Vacation'
    expect(subject).to be_valid
  end

  it 'comments_counter should be greater than or equal to zero' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
    subject.comments_counter = -1
    expect(subject).to_not be_valid
    subject.comments_counter = 2
    expect(subject).to be_valid
  end

  it 'likes_counter should be greater than or equal to zero' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
    subject.likes_counter = -1
    expect(subject).to_not be_valid
    subject.likes_counter = 0
    expect(subject).to be_valid
  end

  it 'Should return the 5 most recent comments' do
    create_comments(subject, user)

    most_recent_comments = subject.most_recent_comments

    most_recent_comments.each_with_index do |comment, i|
      expect(comment.id) == subject.comments.count - i
    end
  end

  it 'should update comments counter' do
    create_comments(subject, user)
    subject.update_comment_counter
    expect(subject.comments_counter) == 7
  end

  it 'should update likes counter' do
    create_likes(subject, user)
    subject.update_like_counter
    expect(subject.likes_counter) == 4
  end

  it 'should increment post counter for the author' do
    prev_counter = subject.author.posts_counter
    subject.increment_post_counter
    expect(subject.author.posts_counter) == prev_counter + 1
  end
end
