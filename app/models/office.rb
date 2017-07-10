class Office < ApplicationRecord
  belongs_to :delegation, optional: true
  belongs_to :parent, class_name: 'Office', optional:true
  has_many :suboffices, class_name: 'Office', foreign_key: 'parent_id'

  ############### VALIDATIONS
  validates_presence_of :name
  validates_uniqueness_of :name

  ############### METHODS
  def get_full_name
    name = self.name.titleize
    if self.parent.present?
      name = name + " (#{self.get_parent_name} - #{self.delegation.name})"
    end
    return name
  end
  def get_delegation_name
    name = self.delegation.present? ? self.delegation.get_name : 'S/D'
    return name
  end
  def get_parent_name
    if self.parent.present?
      name = self.parent.name
    else
      name = 'N/A'
    end
    return name
  end
  def count_lines
    counter = 0
    users = Person.where(office_id: self.id)
    users.each do |user|
      counter = counter + user.lines.count
    end
    return counter
  end
  ############### CLASS METHODS
  def self.get_parent_options
    options = [['N/A',nil]]
    Office.all.each do |o|
      options << [o.name, o.id]
    end
    return options.sort
  end
  def self.get_delegation_options
    options = [['N/A',nil]]
    Delegation.all.each do |o|
      options << [o.name, o.id]
    end
    return options.sort
  end
  def self.get_detailed_list
    offices = []
    self.all.each do |office|
      offices << [office.get_full_name,office.id]
    end
    return offices.sort
  end

end
