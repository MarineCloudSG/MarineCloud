class System < ApplicationRecord
  enum tag: [:boiler, :cooling]
  default_scope { order(sort_order: :asc) }
end
