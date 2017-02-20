class Line < ApplicationRecord
  belongs_to :person, optional: true
end
