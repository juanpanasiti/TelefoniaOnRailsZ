class Line < ApplicationRecord
  belongs_to :person, optional: true

  validates_presence_of :number

  ########## CLASS METHODS
  def self.get_no_data_option
    #Opcion común a casi todos los selectores
    return ['S/D', 'no_data']
  end

  def self.get_has_inet_options
    options = []
    options << self.get_no_data_option
    SelectorSetting.where(selector: 'line_has_inet').each do |o|
      options << [o.name, o.id_name]
    end
    return options
  end

  def self.get_state_options

    options = []
    options << self.get_no_data_option
    SelectorSetting.where(selector: 'line_state').each do |o|
      options << [o.name, o.id_name]
    end
    return options
  end

  def self.get_type_sim_options
    options = []
    options << self.get_no_data_option
    SelectorSetting.where(selector: 'line_type_sim').each do |o|
      options << [o.name, o.id_name]
    end
    return options
  end

  def self.get_bill_account_options
    options = []
    options << self.get_no_data_option
    SelectorSetting.where(selector: 'line_bill_account').each do |o|
      options << [o.name, o.id_name]
    end
    return options
  end
end
