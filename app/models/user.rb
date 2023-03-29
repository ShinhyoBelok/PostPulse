class User < ApplicationRecord
  has_many :posts, class_name: 'Post', foreign_key: :author_id
  has_many :likes, foreign_key: :users_id
  has_many :comments

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def update_post_counter
    self.posts_counter = posts.count
    save
  end
end
