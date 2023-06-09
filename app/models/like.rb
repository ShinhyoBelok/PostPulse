class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post', foreign_key: :posts_id

  after_save :increment_likes_counter

  private

  def increment_likes_counter
    post.increment!(:likes_counter)
  end
end
