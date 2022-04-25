class ParameterSource < ApplicationRecord
  enum source: [:photometer_csv]
  belongs_to :parameter
end
