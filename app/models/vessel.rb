class Vessel < ApplicationRecord
  belongs_to :vessel_group
  has_many :vessel_parameters
end
