class VesselDecorator < ApplicationDecorator
  delegate_all

  decorates_association :vessel_system_parameters

  def chemical_program
    object.chemical_program.name.humanize
  end

  def created_at_date
    object.created_at.to_date
  end

  def last_data_upload_date
    object.last_data_upload&.to_date || 'No uploads in system'
  end
end
