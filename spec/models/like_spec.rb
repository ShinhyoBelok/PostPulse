require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'jinx', photo: 'link', bio: 'player', posts_counter: 0)
  post = Post.create(author: user, title: 'Vacation', text: 'Bluest beach on hawai!', comments_counter: 0,
                     likes_counter: 0)
  subject { Like.new(author: user, post:) }

  before { subject.save }

  it 'like correctly created' do
    expect(subject).to be_valid
  end

  it 'should increment likes counter for post' do
    expect(subject.post.likes_counter) == 1
  end
end
