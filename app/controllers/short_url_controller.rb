class ShortUrlController < ApplicationController
  def redirect
    shortened_url = ShortenedUrl.find_by(short_code: params[:short_code])

    if shortened_url
      # Redirect to the original URL
      redirect_to shortened_url.original_url, allow_other_host: true
    else
      render json: { error: 'Shortened URL not found' }, status: :not_found
    end
  end
end
