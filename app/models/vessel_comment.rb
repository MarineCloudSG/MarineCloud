class VesselComment < ApplicationRecord
  belongs_to :user
  belongs_to :vessel
end
