class Measurement < ApplicationRecord
  belongs_to :parameter
  belongs_to :parameter_source
  belongs_to :vessel
end
