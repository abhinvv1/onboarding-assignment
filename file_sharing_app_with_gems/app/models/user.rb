class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}\z/,
    message: "must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, and one number"
  }, if: :password_required?
  has_many :user_files, dependent: :destroy

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end

  def email_changed?
    false
  end
end
