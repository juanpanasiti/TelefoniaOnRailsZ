class Office < ApplicationRecord
  belongs_to :parent, class_name: 'Office', optional:true
  has_many :suboffices, class_name: 'Office', foreign_key: 'parent_id'
  has_many :users, class_name: 'Person'
  has_many :lines, through: :users #, source: :person

  ############### VALIDATIONS
  validates_presence_of :name
  validates :name, uniqueness: {scope: [:category, :parent_id]}
  #validates_uniqueness_of :name, scope :category , -> { where(category: self.category) }

  ############### METHODS
  def get_full_name
    name = self.name.titleize
    if self.parent.present?
      category = ''
      unless self.category.blank? || (self.category.upcase == self.name.upcase)
        category = self.category + ' '
      end
      name = category + name + " (#{self.get_parent_name})"
    end
    return name
  end
  def get_short_name
    o_category = self.category.present? ? self.category : "N/A"
    o_name = self.name.present? ? self.name : "N/A"
    return "#{o_category.titleize} #{o_name.titleize}"
  end
  def get_parent_name
    if self.parent.present?
      name = self.parent.get_short_name
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
      options << [o.get_full_name, o.id]
    end
    return options.sort
  end

  def self.get_category_options
    options = ["Intendencia","Secretaría","Subsecretaría","Dirección General","Dirección","Subdirección","Departamento","División","Oficina","H.C.D.", "HCD Bloque","N/A"]

    return options
  end #get_category_options

  def self.get_detailed_list
    offices = []
    self.all.each do |office|
      offices << [office.get_full_name,office.id]
    end
    return offices.sort
  end

end
