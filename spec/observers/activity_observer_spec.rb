require 'rails_helper'

RSpec.describe ActivityObserver, type: :observer do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:activity) { FactoryGirl.create(:activity, user: user) }

  describe 'when creating a child activity' do
    let!(:action) do
      proc do
        FactoryGirl.create(:activity)
      end
    end
  end
end
