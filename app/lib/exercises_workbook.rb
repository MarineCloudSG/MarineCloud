# rubocop:disable all
#
# This is experimental code, not to be used in production
# workbook = RubyXL::Parser.parse("baza2.xlsx")['Baza ćwiczeń - Baza ćwiczeń']
class WorksheetType
  include Enumerable
  class_attribute :column_names_row
  class_attribute :primary_column_name

  class_attribute :columns
  self.columns = []

  def self.column(name, options = {})
    columns << OpenStruct.new(
      name: name.downcase.squish,
      alias: options.fetch(:as),
      coercion: options.fetch(:coercion, ->(v) { v }),
      hash: options.fetch(:hash, nil)
    )
  end

  def initialize(worksheet)
    @worksheet = worksheet
    @column_indices = Hash[
      *worksheet[self.class.column_names_row].
        cells.each_with_index.map{|cell, i| [cell.value&.downcase&.squish, i]}.
        reject{|(name, _index)| name.nil? }.
        flatten
    ]
  end

  attr_reader :worksheet, :column_indices

  def each
    current_row = self.class.column_names_row + 1

    while (row = worksheet[current_row]).present?
      if row.cells[column_indices[self.class.primary_column_name.downcase]].value.blank?
        current_row += 1
        next
      end
      entry = self.class.columns.each_with_object({}) do |column, result|
        if column_indices[column.name].nil?
          raise "Cannot find column #{column.name}"
        end

        value = row.cells[column_indices[column.name]].value
        value = column.coercion.call(value) unless value.nil?

        if column.hash.present?
          result[column.alias] ||= {}
          result[column.alias].merge!(column.hash => value)
        else
          result[column.alias] = value
        end
      end

      yield OpenStruct.new(entry)
      current_row += 1
    end
  end
end

class ExercisesWorkbook < WorksheetType
  self.column_names_row = 3
  self.primary_column_name = 'nazwa'

  column 'nazwa', as: :name
  column 'youtube url', as: :youtube_url
  column 'tempo', as: :default_tempo
  column 'powtorzenia', as: :default_reps
  column 'obciazenie mezczyzni sredni', as: :default_weight, coercion: ->(value) do
    return nil unless value.to_s.match(/^\d+$/)

    value
  end
  column 'podstawowe grupy mięśniowe eng', as: :muscle_groups, coercion: ->(v) do
    v.split(',').map do |str|
      I18n.transliterate(str.strip.downcase.gsub(' ', '_'))
    end
  end
  column 'plaszczyzna pracy', as: :plane, coercion: ->(v) do
    v.downcase
  end
end
# rubocop:enable all
