class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # POST /users/sign_in
  def create
    # Authenticate the user with the provided email and password
    self.resource = warden.authenticate!(auth_options)

    # If authentication is successful, issue a JWT token
    render json: { message: 'Logged in successfully', token: generate_jwt_token(resource) }, status: :ok
  end

  # DELETE /users/sign_out
  def destroy
    # Sign out the user
    super do
      head :no_content
    end
  end

  private

  # Generate the JWT token for the authenticated user
  def generate_jwt_token(user)
    JWT.encode({ sub: user.id, exp: 1.day.from_now.to_i }, Rails.application.credentials.devise_jwt_secret_key)
  end
end
