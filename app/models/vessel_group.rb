class VesselGroup < ApplicationRecord
  has_many :vessels, dependent: :nullify
end
