class UsersController < ApplicationController
  before_action :authenticate_user!

  # POST /users/upload
  # Upload a file for the current user
  def upload
    if current_user.nil?
      render json: { error: 'User not authenticated' }, status: :unauthorized
      return
    end

    uploaded_file = params[:file]
    if uploaded_file.nil?
      render json: { error: 'No file provided' }, status: :unprocessable_entity
      return
    end

    attachment = current_user.attachments.new
    attachment.file.attach(uploaded_file)
    attachment.title = params[:title]
    attachment.description = params[:description]
    attachment.file_type = uploaded_file.content_type

    if attachment.save
      url = url_for(attachment.file)
      shortened_code = ShortenedUrl.find_or_create_shortened_url(original_url: url)
      render json: {
        message: 'File uploaded successfully',
        user: current_user,
        tiny_url: short_url(shortened_code),
        type: uploaded_file.content_type
      }, status: :created
    else
      render json: { error: 'Failed to upload file', details: attachment.errors.full_messages }, status: :unprocessable_entity
    end
  end


  # GET /users/files
  # Fetch all files uploaded by the current user
  def files
    if current_user.nil?
      render json: { error: 'User not authenticated' }, status: :unauthorized
      return
    end

    attachments_by_user = current_user.attachments
    render json: {
      user: current_user,
      files: attachments_by_user.map { |attachment| 
        {
          name: attachment.file.filename.to_s,
          url: short_url(ShortenedUrl.find_or_create_shortened_url( url_for(attachment.file))), # Generate the full URL for the file
          type: attachment.file_type
        }
      }
    }, status: :ok
  end


  # POST /users/files/delete
  # Delete a file uploaded by the current user
  def delete_file
    if current_user.nil?
      render json: { error: 'User not authenticated' }, status: :unauthorized
      return
    end

    attachment = current_user.attachments.find_by(id: params[:id])
    if attachment.nil?
      render json: { error: 'File not found' }, status: :not_found
      return
    end

    attachment.destroy
    render json: { message: 'File deleted successfully' }, status: :ok
  end

  private

  # Helper to generate the full tiny URL
  def short_url(short_code)
    "#{request.base_url}/s/#{short_code}"
  end
end
