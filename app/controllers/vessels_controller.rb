# frozen_string_literal: true

class VesselsController < BaseController
  layout :vessel_page_layout

  def home
    return redirect_to action: :show, id: managed_vessels.first.id if managed_vessels.count == 1

    render locals: {
      date_range: date_range,
      vessel_group_ids: vessel_group_ids,
      vessels: search_filtered_vessels,
      selected_vessel_group_ids: selected_vessel_group_ids,
      vessel_search_query: vessel_search_query,
      keep_params: params.permit(:start_date, :end_date, vessel_group_ids: [])
    }
  end

  def index
    return redirect_to action: :show, id: managed_vessels.first.id if managed_vessels.count == 1

    render locals: {
      date_range: date_range,
      vessel_group_ids: vessel_group_ids,
      vessels: search_filtered_vessels,
      selected_vessel_group_ids: selected_vessel_group_ids,
      vessel_search_query: vessel_search_query,
      keep_params: params.permit(:start_date, :end_date, vessel_group_ids: [])
    }
  end

  def overview
    return redirect_to action: :show, id: managed_vessels.first.id if managed_vessels.count == 1

    render locals: {
      grouped_system_parameters: filtered_system_parameters,
      date_range: date_range,
      vessel_ids: vessel_ids,
      vessel_group_ids: vessel_group_ids,
      available_systems: available_systems,
      chemical_providers: chemical_providers,
      selected_chemical_provider: selected_chemical_provider,
      selected_system: selected_system,
      vessel_search_query: vessel_search_query,
      keep_params: params.permit(:start_date, :end_date, :system_id, vessel_group_ids: [])
    }
  end

  def show
    super do
      @export_page = params.fetch(:export_page, false)
      @vessel_tested_by = vessel_tested_by

      return render template: "vessels/#{vessel_show_template}", locals: {
        vessel: resource,
        date_range: date_range,
        comments: comments,
        charts_data_by_system: charts_data_by_system,
        assigned_date: date_range.end.to_date.beginning_of_month,
        available_systems: available_systems,
        selected_system: selected_system,
        available_parameters: available_parameters,
        selected_parameters: selected_parameters,
        export_url_params: export_url_params
      }
    end
  end

  private

  def search_filtered_vessels
    return vessels if vessel_search_query.nil?

    vessels.where('name ILIKE ?', "%#{vessel_search_query}%")
  end

  def vessels
    vessels = vessel_group_ids ? collection.where(vessel_group_id: vessel_group_ids) : collection
    if selected_chemical_provider
      vessels = vessels.joins(:chemical_provider).where(chemical_provider: selected_chemical_provider)
    end
    # if selected_systems.any?
    #   vessels = vessels.joins(:chemical_provider).where(chemical_provider: selected_chemical_providers)
    # end
    vessels.includes(:measurements_imports).order('measurements_imports.created_at DESC NULLS LAST')
  end

  def export_url_params
    params.permit(:start_date, :end_date, :system_id, parameter_ids: []).merge({ export_page: true })
  end

  def vessel_show_template
    return 'export_show' if export_page?

    'show'
  end

  def vessel_page_layout
    return 'pdf_export' if export_page?
    return 'application_with_background' if action_name.eql? 'home'

    'application'
  end

  def export_page?
    params.fetch(:export_page, false)
  end

  def vessel_tested_by
    testers = VesselTestersForDateRangeQuery.call(vessel_id: resource.id, date_range: date_range).pluck(:tested_by)
    return if testers.count > 1

    testers.first
  end

  def managed_vessels
    current_user.managed_vessels
  end

  def comments
    resource.comments
            .where(assigned_date: date_range)
            .order(assigned_date: :desc, created_at: :desc)
  end

  def charts_data_by_system
    VesselChartsDataBySystem.result_for(
      vessel: resource,
      date_range: date_range,
      system: selected_system,
      parameter_ids: selected_parameter_ids
    )
  end

  def date_range
    start_date..end_date
  end

  def end_date
    params[:end_date]&.to_date || start_date.beginning_of_month + 1.month
  end

  def start_date
    params[:start_date]&.to_date || default_start_date
  end

  def default_start_date
    prev_month = Date.today.beginning_of_month - 1.month
    if params[:id].nil?
      prev_month
    else
      resource.last_month_with_measurements || prev_month
    end
  end

  def vessel_group_ids
    params.fetch(:vessel_group_ids, current_user.vessel_groups.pluck(:id)).map(&:to_i)
  end

  def selected_vessel_group_ids
    params[:vessel_group_ids]&.map(&:to_i)
  end

  def vessel_search_query
    params.fetch(:vessel_search_query, nil)
  end

  def vessel_ids
    search_filtered_vessels.pluck(:id).uniq
  end

  def filtered_system_parameters
    grouped_system_parameters.map do |system, params|
      system_unique_params = params.uniq &:parameter_id
      [system, system_unique_params]
    end.to_h
  end

  def grouped_system_parameters
    SystemParametersForVesselIdsQuery.call(vessel_ids: vessel_ids).group_by(&:system)
  end

  def available_systems
    systems = params[:id].nil? ? System.all : resource.systems
    systems.order(sort_order: :asc)
  end

  def chemical_providers
    ChemicalProvider.all
  end
  def selected_chemical_provider
    params[:chemical_provider].present? ? params[:chemical_provider].to_i : nil
  end

  def selected_system_id
    params[:system_id]
  end

  def selected_system
    if selected_system_id.blank?
      available_systems.first
    else
      available_systems.find(selected_system_id)
    end
  end

  def available_parameter_ids
    params = VesselSystemParameter.joins(:vessel_system).select(:parameter_id).distinct.where(vessel_systems: { vessel: resource })
    params = params.where(vessel_systems: { system: selected_system }) unless selected_system.nil?
    params
  end

  def available_parameters
    Parameter.where(id: available_parameter_ids)
  end

  def selected_parameter_ids
    params[:parameter_ids] || available_parameter_ids
  end

  def selected_parameters
    return available_parameters if selected_parameter_ids.blank?

    available_parameters.where(id: selected_parameter_ids)
  end
end
