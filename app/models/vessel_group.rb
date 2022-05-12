class VesselGroup < ApplicationRecord
  has_many :vessels, dependent: :nullify
  has_and_belongs_to_many :users
end
