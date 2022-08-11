class AddExistingCountries < ActiveRecord::Migration[7.0]
  def change
    flags_dir = 'icons/flags'
    add_column :countries, :flag_file, :string
    Dir.glob("app/assets/images/#{flags_dir}/*.svg").map do |p|
      basename = File.basename(p, '.svg')
      name = basename.humanize.titleize
      Country.create(name: name, flag_file: "#{flags_dir}/#{basename}.svg")
    end
  end
end
