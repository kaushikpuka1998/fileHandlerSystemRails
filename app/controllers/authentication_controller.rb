class AuthenticationController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      # Generate JWT Token
      token = generate_jwt(user)

      render json: { message: 'Login successful', user: user, token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def generate_jwt(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
