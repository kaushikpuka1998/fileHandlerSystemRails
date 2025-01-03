class ShortenedUrl < ApplicationRecord
  validates :original_url, presence: true
  validates :short_code, presence: true, uniqueness: true

  before_validation :generate_short_code, on: :create

  def self.find_or_create_shortened_url(url)
    if url.is_a?(String)
      shortened_url = ShortenedUrl.find_by(original_url: url) 
      return shortened_url.short_code
    end
  
    # If the shortened URL doesn't exist, create a new one
    if shortened_url.nil?
      shortened_url = ShortenedUrl.create!(original_url: url[:original_url])
    end
  
    # Return only the short_code
    shortened_url.short_code
  end
  

  private

  # Generate a unique short code
  def generate_short_code
    self.short_code ||= SecureRandom.alphanumeric(8) # 8-character random string
  end
end
