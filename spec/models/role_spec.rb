require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { FactoryGirl.build(:role) }

  subject { role }

  it { should respond_to(:group) }

  it { should belong_to(:group) }

  it { should be_valid }
end
