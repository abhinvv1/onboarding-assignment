class UserFile < ApplicationRecord
  belongs_to :user

  before_validation :set_default_name
  before_create :set_upload_date, :set_file_size, :set_content_type
  before_save :generate_public_url, if: :public_changed?

  validates :name, presence: true, uniqueness: { scope: :user_id, message: "File already present" }
  validates :file_data, presence: true

  private

  def set_default_name
    self.name ||= file_data.original_filename if file_data.respond_to?(:original_filename)
  end

  def set_upload_date
    self.upload_date = Date.today
  end

  def set_file_size
    self.size = file_data.size
  end

  def set_content_type
    self.content_type = file_data.content_type if file_data.respond_to?(:content_type)
  end

  def generate_public_url
    self.public_url = SecureRandom.uuid if public?
  end
end
