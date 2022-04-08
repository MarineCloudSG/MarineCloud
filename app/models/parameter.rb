class Parameter < ApplicationRecord
  enum system: [:boiler, :engine_cooling_system]
end
