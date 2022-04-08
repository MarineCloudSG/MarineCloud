class VesselsController < BaseController

  def show
    super do
      @trackable_metrics = resource.vessel_parameters.map do |vessel_parameter|
        values = (0..10).to_a.reverse.each_with_object({}) do |index, result|
          result[(Date.current - index.days).iso8601] = rand(100)
        end

        OpenStruct.new(
          name: vessel_parameter.parameter.label,
          last_value: values[Date.current.iso8601],
          trend: values
        )
      end
    end
  end
  protected

end
