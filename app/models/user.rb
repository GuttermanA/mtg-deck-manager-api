class User < ApplicationRecord
  has_many :decks
  validates :name, presence: true
  validates :password, presence: true
  has_secure_password
end
