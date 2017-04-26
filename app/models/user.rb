class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :watchlists
  has_one :portfolio

  def username
    "#{self.first_name}#{self.last_name}"
  end
end
