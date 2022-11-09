class Download < ApplicationRecord
  has_one_attached :attachment

  default_scope { order(order: :asc) }

end
