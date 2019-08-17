class User < ApplicationRecord
  has_secure_password

  has_many :categories, foreign_key: :created_by
  validates_presence_of :login, :email, :password_digest
  validates :email, uniqueness: true
end
