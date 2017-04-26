class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :stocks
  accepts_nested_attributes_for :stocks,
      reject_if: lambda { |attrs| attrs['symbol'].blank? },
      allow_destroy: true
end
