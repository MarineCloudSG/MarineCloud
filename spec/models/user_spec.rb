require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#managed_vessels' do
    it "retrieves all vessels with user's id or vessel group managed by user" do
      user = create :user
      vessel1 = create :vessel, user: user
      vessel2 = create :vessel
      vessel3 = create :vessel
      vessel4 = create :vessel
      create :vessel_group, users: [user], vessels: [vessel2]
      create :vessel_group, users: [user], vessels: [vessel3]
      create :vessel_group, vessels: [vessel4]

      managed_vessels = user.managed_vessels

      expect(managed_vessels).to contain_exactly(vessel1, vessel2, vessel3)
    end
  end
end
