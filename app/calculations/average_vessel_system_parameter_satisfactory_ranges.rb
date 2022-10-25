class AverageVesselSystemParameterSatisfactoryRanges < Patterns::Calculation

  private

  def result
    SatisfactoryRangeChartLines.new(max_satisfactory_range: highest_satisfactory_range, min_satisfactory_range: lowest_satisfactory_range).chart_lines
  end

  def highest_satisfactory_range
    chemical_provider_parameter&.min_satisfactory
  end

  def lowest_satisfactory_range
    chemical_provider_parameter&.max_satisfactory
  end

  def chemical_provider_parameter
    @chemical_provider_parameter ||= ChemicalProviderParameter.find_by(parameter_id: parameter, system_id: system, chemical_provider: chemical_provider)
  end

  def system
    options.fetch(:system)
  end

  def parameter
    options.fetch(:parameter)
  end

  def chemical_provider
    options.fetch(:chemical_provider)
  end
end
