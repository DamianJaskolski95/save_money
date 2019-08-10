require 'rails_helper'

RSpec.describe Expense, type: :model do
  it { should belong_to(:category) }
  it { should validate_presence_of(:month) }
  it { should validate_presence_of(:planned_value) }
end
