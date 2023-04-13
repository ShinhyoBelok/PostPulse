class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    authorization_header = request.headers['Authorization']
    if authorization_header
      token = authorization_header.split.last
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' })
      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  attr_reader :current_user
end
