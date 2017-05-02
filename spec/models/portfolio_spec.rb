require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  it { should have_many(:stocks).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
end
