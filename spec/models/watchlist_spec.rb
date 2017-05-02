require 'rails_helper'

RSpec.describe Watchlist, type: :model do
  it { should have_many(:stocks).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end
