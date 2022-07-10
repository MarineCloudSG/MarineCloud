class ChemicalProviderParameter < ApplicationRecord
  belongs_to :chemical_provider
  belongs_to :system
  belongs_to :parameter
end
