class UserFile < ApplicationRecord
  belongs_to :user
  mount_uploader :file, FileUploader

  validates :name, presence: true, uniqueness: { scope: :user_id, message: "File already present" }
  validates :file, presence: true

  scope :latest_first, -> { order(created_at: :desc) }
end
