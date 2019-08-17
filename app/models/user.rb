class User < ApplicationRecord
  include Swagger::Blocks
  has_secure_password

  has_many :categories, foreign_key: :created_by
  validates_presence_of :login, :email, :password_digest

  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: EMAIL_FORMAT, message: "wrong format" }, uniqueness: true

  swagger_schema :User do
    key :required, [:id, :login, :email, :password_digest]
    property :id do
      key :type, :integer
    end
    property :login do
      key :type, :string
    end
    property :email do
      key :type, :string
    end
    property :password_digest do
      key :type, :string
      key :format, :password
    end
  end


end
