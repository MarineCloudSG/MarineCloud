class ImportLog < ApplicationRecord
  belongs_to :measurements_import
  belongs_to :vessel
end
