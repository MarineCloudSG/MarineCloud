class VesselSystemParameter < ApplicationRecord
  belongs_to :vessel_system
  belongs_to :parameter
  belongs_to :vessel

  before_validation :set_vessel_id

  private

  def set_vessel_id
    self.vessel_id = vessel_system.vessel_id
  end
end
