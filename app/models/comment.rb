class Comment < ApplicationRecord
    belongs_to :post, class_name: 'Post', foreign_key: :posts_id
    belongs_to :author, class_name: 'User', foreign_key: :users_id
end