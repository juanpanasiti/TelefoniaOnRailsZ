class Delegation < ApplicationRecord

  ############### VALIDATIONS
  validates_presence_of :name
  validates_uniqueness_of :name
  def get_name
    return self.name.titleize
  end
end
