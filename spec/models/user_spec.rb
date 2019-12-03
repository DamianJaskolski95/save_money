require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:categories) }
  it { should have_many(:balances) }
  it { should have_many(:cycles) }

  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
