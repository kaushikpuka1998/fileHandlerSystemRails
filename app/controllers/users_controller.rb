class UsersController < ApplicationController
  before_action :authenticate_user!

  # POST /users/upload
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

    if attachment.save
      # Generate the original URL for the file
      original_url = url_for(attachment.file)

      # Create a shortened URL entry
      shortened_url = ShortenedUrl.find_or_create_shortened_url(original_url: original_url)

      render json: {
        message: 'File uploaded successfully',
        user: current_user,
        tiny_url: short_url(shortened_url.short_code)
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

    attachments = current_user.attachments

    render json: {
      user: current_user,
      files: attachments.map { |attachment| 
        {
          name: attachment.file.filename.to_s,
          url: short_url(ShortenedUrl.find_or_create_shortened_url( url_for(attachment.file))) # Generate the full URL for the file
        }
      }
    }, status: :ok
  end

  private

  # Helper to generate the full tiny URL
  def short_url(short_code)
    "#{request.base_url}/s/#{short_code}"
  end
end
