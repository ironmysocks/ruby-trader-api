class Watchlist < ApplicationRecord
  belongs_to :user

  has_many :stocks, as: :stockholder, :dependent => :destroy

  accepts_nested_attributes_for :stocks,
      reject_if: lambda { |attrs| attrs['symbol'].blank? },
      allow_destroy: true

  validates_presence_of :user_id, :name

end
