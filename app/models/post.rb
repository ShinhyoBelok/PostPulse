class Post < ApplicationRecord
  has_many :comments, foreign_key: :posts_id
  has_many :likes, foreign_key: :posts_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }

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

  after_save :update_post_counter

  private

  def update_post_counter
    author.update(posts_counter: Post.where(author_id: author.id).length)
  end
end
