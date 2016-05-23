require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:bio) }

  it { should validate_presence_of(:name) }

  it { should be_valid }
end
