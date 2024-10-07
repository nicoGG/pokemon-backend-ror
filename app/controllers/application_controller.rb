class ApplicationController < ActionController::API
  before_action :authorized

  def authorized
    render json: { message: 'Por favor, inicia sesión' }, status: :unauthorized unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def decoded_token
    if request.headers['Authorization']
      token = request.headers['Authorization'].split(' ')[1]
      begin
        JWT.decode(token, Rails.application.credentials[:jwt_secret], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

end