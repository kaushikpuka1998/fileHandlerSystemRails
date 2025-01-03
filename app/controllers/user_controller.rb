class UserController < Devise::RegistrationsController
  def index
    @user = current_user
    render json: @user
  end

  def create
    user = User.new(sign_up_params)
    if user.save!
      render json: { message: "User created successfully", user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    file = current_user
    file.destroy
    render json: { message: "User deleted successfully" }
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
