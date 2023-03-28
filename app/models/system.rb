class System < ApplicationRecord
  enum tag: [:boiler, :cooling, :feedwater]
  default_scope { order(sort_order: :asc) }
end
