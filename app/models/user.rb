class User < ApplicationRecord
  # change default inheritance_column
  self.inheritance_column = :role

  MIN_PASSWORD_LENGTH = 8.freeze
  MAX_STRING_LENGTH = 50.freeze
  MAX_DB_STRING_LENGTH = 255.freeze
  USER_ROLES = ['Teacher', 'Student'].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable

  validates_presence_of :name, :role

  validates_confirmation_of :password, :message => "should match confirmation"

  validates :name, length: { maximum: MAX_STRING_LENGTH }
  validates :email, length: { maximum: MAX_DB_STRING_LENGTH }
  validates :password, length: { maximum: 255, minimum: MIN_PASSWORD_LENGTH }, if: -> { password.present? }
end
