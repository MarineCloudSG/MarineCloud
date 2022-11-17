class AverageMeasurementsForMultipleParameters < Patterns::Calculation

  private

  def result
    System.where(tag: tag).map do |system|
      { name: system.name, data: AverageVesselSystemParameterMeasurements.result_for(
        parameter: parameter, vessel_ids: vessel_ids,
        system: system,
        date_range: date_range
      )
      }
    end
  end

  def parameter
    options.fetch(:parameter)
  end

  def tag
    options.fetch(:tag)
  end

  def vessel_ids
    options.fetch(:vessel_ids)
  end

  def date_range
    options.fetch(:date_range)
  end
end
