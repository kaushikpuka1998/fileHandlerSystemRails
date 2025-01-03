class Attachment < ApplicationRecord
  belongs_to :user # Using ActiveStorage for file handling
  has_one_attached :file

  validates :file, presence: true
end
