class Cell < ApplicationRecord
  belongs_to :internal
  belongs_to :row
end
