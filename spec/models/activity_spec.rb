require 'rails_helper'

RSpec.describe Activity, type: :model do
  let!(:activity) { FactoryGirl.create(:activity) }

  subject { activity }

  it_behaves_like 'Activity'
end
