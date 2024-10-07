class AuthController < ApplicationController
    skip_before_action :authorized, only: [:login]
  
    def login
      @user = User.find_by(username: params[:username])
  
      if @user && @user.authenticate(params[:password])
        token = encode_token({ user_id: @user.id })
        render json: { token: token }, status: :ok
      else
        render json: { error: 'Credenciales inválidas' }, status: :unauthorized
      end
    end
  
    private
  
    def encode_token(payload)
      JWT.encode(payload, Rails.application.credentials[:jwt_secret])
    end
  end