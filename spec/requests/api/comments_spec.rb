require 'swagger_helper'

describe 'Comments API' do
  path '/api/users/1/posts/1/comments' do
    get 'Retrieves all comments for a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :post_id, in: :query, type: :integer

      response '200', 'comments found' do
        let(:post) { create(:post) }
        let(:post_id) { post.id }

        run_test!
      end

      response '404', 'post not found' do
        let(:post_id) { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/users/1/posts/1/comments' do
    post 'Creates a comment for a post' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: %w[text user_id post_id author_id]
      }

      response '201', 'comment created' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user:) }
        let(:comment) { build(:comment, user:, post:) }
        let(:comment) do
          { text: comment.text, user_id: comment.user.id, post_id: comment.post.id, author_id: comment.author.id }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { create(:user) }
        let(:post) { create(:post, user:) }
        let(:comment) { build(:comment, user:, post:) }
        let(:comment) { { text: '', user_id: comment.user.id, post_id: comment.post.id, author_id: comment.author.id } }

        run_test!
      end
    end
  end
end
