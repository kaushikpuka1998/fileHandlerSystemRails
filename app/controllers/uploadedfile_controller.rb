class UploadedfileController < ApplicationController
  before_action :authenticate_user!

  def create
    uploaded_file = current_user.uploaded_files.new(uploaded_file_params)
    if uploaded_file.save
      uploaded_file.file.attach(params[:file])
      render json: { message: "File uploaded successfully", file: uploaded_file }, status: :created
    else
      render json: { errors: uploaded_file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def uploaded_file_params
    params.require(:uploaded_file).permit(:title, :description)
  end
end
