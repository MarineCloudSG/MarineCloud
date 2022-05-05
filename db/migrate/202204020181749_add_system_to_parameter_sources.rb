class AddSystemToParameterSources < ActiveRecord::Migration[7.0]
  def change
    add_reference :parameter_sources, :system, null: true, foreign_key: true
  end
end
