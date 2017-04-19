class Office < ApplicationRecord
  belongs_to :delegation, optional: true
  belongs_to :parent, class_name: 'Office', optional:true
  has_many :suboffices, class_name: 'Office', foreign_key: 'parent_id'

  ############### VALIDATIONS
  validates_presence_of :name

  ############### METHODS
  def get_parent_name
    if self.parent.present?
      name = self.parent.name
    else
      name = 'N/A'
    end
    return name
  end
  ############### CLASS METHODS
  def self.get_parent_options
    options = [['N/A',nil]]
    Office.all.each do |o|
      options << [o.name, o.id]
    end
    return options
  end
  def self.get_delegation_options
    options = [['N/A',nil]]
    Delegation.all.each do |o|
      options << [o.name, o.id]
    end
    return options
  end

end
