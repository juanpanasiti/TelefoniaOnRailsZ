class Internal < ApplicationRecord
  ########## RELATIONS
  belongs_to :office
  ########## VALIDATES
  validates_presence_of :name, :office_id, :prefix, :number, :kind

  ########## METHODS
  def get_name
    name = ''
    i_name = self.name.present? ? self.name.titleize : "N/A"
    i_aclaration = self.aclaration.present? ? self.aclaration.titleize : "N/A"
    name = "#{i_name} (#{i_aclaration})"
    return name
  end

  def get_number
    number = ''
    i_prefix = self.prefix.present? ? self.prefix : "N/A"
    i_number = self.number.present? ? self.number : "N/A"
    number = i_prefix + i_number
    return number
  end

  def get_kind
    kind = ''
    kind = self.kind.present? ? self.kind.titleize : "N/A"
    return kind
  end

  def get_office
    office = ''
    office = self.office.present? ? self.office.get_full_name : "N/A"
    return office
  end #get_office

  ######### CLASS METHODS
  def self.get_kind_line_options
    return ["Analógica", "Digital", "IP"]
  end
end
