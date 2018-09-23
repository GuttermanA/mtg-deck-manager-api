class User < ApplicationRecord
  has_many :collections
  has_many :decks
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password

  def self.create_admin
    if !self.find_by(name: admin)
      User.create(name: "admin", password: "1234", admin: true)
      puts "Admin account created"
    else
      puts "Admin account already exists"
    end
  end
end
