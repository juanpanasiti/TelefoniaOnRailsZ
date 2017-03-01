class Office < ApplicationRecord
  belongs_to :delegation, optional: true
  belongs_to :parent, class_name: 'Office', optional:true
  has_many :suboffices, class_name: 'Office', foreign_key: 'parent_id'

  ############### VALIDATIONS
  validates_presence_of :name

  ############### METHODS

end
