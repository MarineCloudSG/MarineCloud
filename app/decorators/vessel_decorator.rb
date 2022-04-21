class VesselDecorator < ApplicationDecorator
  delegate_all

  decorates_association :vessel_system_parameters

  def chemical_program
    object.chemical_program.humanize
  end
end
