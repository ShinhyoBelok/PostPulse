class Comment < ApplicationRecord
  belongs_to :post, class_name: 'Post', foreign_key: :posts_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  after_save :increment_comments_counter

  private

  def increment_comments_counter
    post.increment!(:comments_counter)
  end
end
