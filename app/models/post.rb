class Post < ApplicationRecord
  has_many :comments, foreign_key: :posts_id
  has_many :likes, foreign_key: :posts_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_comment_counter
    self.comments_counter = comments.count
    save
  end

  def update_like_counter
    self.likes_counter = likes.count
    save
  end
end
