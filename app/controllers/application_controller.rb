class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_user!
    token = request.headers["Authorization"].to_s.split(" ").last

    if token.blank?
      render json: { error: "Unauthorized" }, status: :unauthorized
      return
    end

    begin
      decoded_token = JWT.decode(token, Rails.application.secret_key_base)[0]
      @current_user = User.find_by(id: decoded_token["user_id"])

      if @current_user.nil?
        render json: { error: "User not found" }, status: :unauthorized
        return
      end
    rescue JWT::DecodeError => e
      render json: { error: "Invalid or expired token" }, status: :unauthorized
    end
  end
end
