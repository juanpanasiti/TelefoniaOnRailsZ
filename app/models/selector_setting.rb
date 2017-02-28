class SelectorSetting < ApplicationRecord
  validates_presence_of :name, :name_id, :selector
end
