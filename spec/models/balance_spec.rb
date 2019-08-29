require 'rails_helper'

RSpec.describe Balance, type: :model do
  it { should validate_presence_of(:income) }
  it { should validate_presence_of(:created_by) }
end
