class ChangeChemicalProviderForeignKeyToCascade < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :chemical_provider_parameters, :chemical_providers
    add_foreign_key :chemical_provider_parameters, :chemical_providers, on_delete: :cascade
  end
end
