require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:expenses).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }
end
