class ParameterRecommendation < ApplicationRecord
  belongs_to :parameter
  belongs_to :chemical_program
end
