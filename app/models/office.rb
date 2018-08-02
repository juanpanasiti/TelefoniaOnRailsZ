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
  def get_name
    h_cat = Office.get_high_categories
    name = ''
    unless self.category.blank?
      office = self
      while not(h_cat.include?(office.category)) && office.parent.present? do
        office = office.parent
      end
      name = office.category
      unless (office.category.upcase == office.name.upcase)
        name = name + ' ' + office.name.titleize
      end #unless
    else #category is blank
      name = 'Actualizar nombre > ' + self.name
    end #unless
    return name
  end #get_name

  def get_trace
    trace = ''
    office = self
    while office.parent.present? do
      parent = office.parent
      trace = trace + parent.get_short_name
      if parent.parent.present?
        trace = trace + ' >> '
        office = parent
      else #parent hasn't a parent
        break
      end #if
    end #while
    return trace
  end #get_trace

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
    if o_category.upcase == o_name.upcase
      return o_name.titleize
    else
      return "#{o_category.titleize} #{o_name.titleize}"
    end
  end
  def get_parent_name
    if self.parent.present?
      name = self.parent.get_short_name
    else
      name = 'N/A'
    end
    return name
  end
  def get_lines
    lines = self.lines.current_lines
    suboff = self.suboffices
    suboff.each do |so|
      lines = lines + so.get_lines
    end
    return lines
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
    options = self.get_high_categories + self.get_low_categories + ["NS/NA"]

    return options
  end #get_category_options

  def self.get_detailed_list
    offices = []
    self.all.each do |office|
      offices << [office.get_full_name,office.id]
    end
    return offices.sort
  end

  private
  ############### HELPERS
  def self.get_high_categories
    options = ["Intendencia","Secretaría","Subsecretaría","Dirección General","Dirección"]
    return options
  end
  def self.get_low_categories
    options = ["Subdirección","Departamento","División","Oficina","H.C.D.", "HCD Bloque"]
    return options
  end

end
