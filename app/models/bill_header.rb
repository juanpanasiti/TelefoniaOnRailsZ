class BillHeader < ApplicationRecord
  ####### VALIDATIONS
  validates_presence_of :short_name, :name, :type_field, :type_value
  validates_uniqueness_of :order, :short_name, :name, allow_blank: true

  ####### CLASS MATHODS
  def self.get_type_field_options
    options = ['Monto','Cantidad','Sumar al final','Ignorar']
    return options
  end
  def self.get_type_value_options
    options = ['Entero','Decimal']
    return options
  end
end
