FactoryGirl.define do

  factory :watchlist, class: Watchlist do
    name { Faker::Lorem.word }
    user

    trait :with_stocks do
      transient do
        stocks_count 5
      end
      
      after(:create) do |watchlist, evaluator|
        create_list(:stock, evaluator.stocks_count, stockholder: watchlist)
      end
    end
  end

end
