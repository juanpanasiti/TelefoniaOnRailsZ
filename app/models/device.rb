class Device < ApplicationRecord
  belongs_to :device_model
  belongs_to :line, optional: true
end
