FactoryGirl.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.email}
    password {Faker::Internet.password}

    trait :with_portfolio do
      after(:create) do |user, evaluator|
        create(:portfolio, user: user)
      end
    end

    trait :with_watchlists do
      transient do
        stocks_count 5
      end
      after(:create) do |user, evaluator|
        create_list(:watchlist, evaluator.stocks_count, user: user)
      end
    end

  end
end
