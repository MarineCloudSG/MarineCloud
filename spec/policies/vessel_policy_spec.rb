require 'rails_helper'

RSpec.describe VesselPolicy, type: :policy do
  describe 'Scope' do
    it 'scopes all vessels managed by user' do
      user = create :user
      vessel1 = create :vessel, user: user
      vessel_group = create :vessel_group, users: [user]
      vesser2 = create :vessel, vessel_group: vessel_group
      create :vessel

      expect(Pundit.policy_scope!(user, Vessel).pluck(:id)).to match_array([vessel1.id, vesser2.id])
    end
  end

  permissions :show?, :update?, :destroy? do
    it 'denies access if user is not managing ship anyhow' do
      expect(VesselPolicy).to_not permit(User.new, Vessel.new)
    end

    it 'grants access if user is a vessel manager' do
      user = create :user
      vessel = create :vessel, user: user
      expect(VesselPolicy).to permit(user, vessel)
    end

    it 'grants access if user is a vessel group manager' do
      user = create :user
      vessel_group = create :vessel_group, users: [user]
      vessel = create :vessel, vessel_group: vessel_group
      expect(VesselPolicy).to permit(user, vessel)
    end
  end
end
