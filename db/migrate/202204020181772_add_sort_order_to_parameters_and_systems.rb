class AddSortOrderToParametersAndSystems < ActiveRecord::Migration[7.0]
  def change
    add_column :parameters, :sort_order, :integer, default: 10
    add_column :systems, :sort_order, :integer, default: 10
  end
end
