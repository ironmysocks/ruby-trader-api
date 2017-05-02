class User < ApplicationRecord

  has_many :watchlists
  has_one :portfolio

  validates_presence_of :first_name, :last_name, :email, :password_digest
  validates_uniqueness_of :email, :case_sensitive => true

  has_secure_password

end
