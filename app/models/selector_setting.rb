class SelectorSetting < ApplicationRecord
  validates_presence_of :name, :id_name, :selector

  ########## CLASS METHODS
  def self.get_selector_options
    # Devuelve un array con las duplas de opciones para el selector
    options = [ ['Línea >> Pack Inet','line_has_inet'],
                ['Línea >> Estado','line_state'],
                ['Línea >> Tipo SIM','line_type_sim'],
                ['Línea >> Cuenta','line_bill_account'] ]
    return options
  end #END get_selector_options

end
