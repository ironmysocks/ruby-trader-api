FactoryGirl.define do
  factory :stock, class: Stock do
    symbol { Faker::Address.state_abbr }
    alert_price { Faker::Number.decimal(2,2) }
    association :stockholder
  end
end
