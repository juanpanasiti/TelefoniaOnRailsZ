class Delegation < ApplicationRecord

  ############### VALIDATIONS
  validates_presence_of :name
  validates_uniqueness_of :name
  def get_name
    name = self.name.present? ? self.name.titleize : 'S/D'
    return name
  end
end
