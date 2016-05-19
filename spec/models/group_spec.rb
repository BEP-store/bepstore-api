require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) { FactoryGirl.create(:group) }

  subject { group }

  it { should be_valid }
end
