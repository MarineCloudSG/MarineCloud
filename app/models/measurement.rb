class Measurement < ApplicationRecord
  belongs_to :vessel_system_parameter
  belongs_to :parameter_source, optional: true
  has_one :parameter, through: :vessel_system_parameter
  has_one :vessel_system, through: :vessel_system_parameter
  has_one :system, through: :vessel_system
  has_one :vessel, through: :vessel_system

  enum state: %i[in_range overrange underrange]
end
