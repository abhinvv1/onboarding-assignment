require 'digest'

class User < ApplicationRecord
  attr_accessor :password
  has_many :user_files, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create, length: { minimum: 8 }
  validate :password_complexity

  before_save :hash_password

  def authenticate(password)
    self.password_digest == hash_password_digest(password)
  end

  private

  def password_required?
    new_record? || password.present?
  end

  def password_complexity
    return if password.blank?
    unless password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/)
      errors.add :password, "must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, and one number"
    end
  end

  def hash_password
    if password.present?
      self.password_digest = hash_password_digest(password)
    end
  end

  def hash_password_digest(string)
    Digest::SHA256.hexdigest(string)
  end
end