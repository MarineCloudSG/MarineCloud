class ChemicalProvider < ApplicationRecord
  has_many :chemical_provider_parameters

  accepts_nested_attributes_for :chemical_provider_parameters
end
