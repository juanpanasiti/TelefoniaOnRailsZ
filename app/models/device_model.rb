class DeviceModel < ApplicationRecord
  ########## VALIDATES
  validates_presence_of :mark, :device_name, :type_sim, :category
  validates_uniqueness_of :device_code
  ########## METHODS
end
