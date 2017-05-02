FactoryGirl.define do
  factory :portfolio, class: Portfolio do
    user

    trait :with_stocks do
      transient do
        stocks_count 5
      end

      after(:create) do |portfolio,evaluator|
        create_list(:stock, evaluator.stocks_count, stockholder: portfolio)
      end
    end

  end
end
