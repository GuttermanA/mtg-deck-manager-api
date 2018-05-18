class User < ApplicationRecord
  has_many :collections
  has_many :decks
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password
end
