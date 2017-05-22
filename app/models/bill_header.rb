class BillHeader < ApplicationRecord
  ####### VALIDATIONS
  validates_presence_of :short_name, :name, :type_field, :type_value
  validates_uniqueness_of :order, :short_name, :name, allow_blank: true

  ####### SCOPES
  scope :field_amount,   ->(){ where(type_field: 'Monto') }
  scope :field_quantity,   ->(){ where(type_field: 'Cantidad') }
  scope :field_sum_end,   ->(){ where(type_field: 'Sumar al final') }
  scope :field_ignore,   ->(){ where(type_field: 'Ignorar') }
  ####### CLASS MATHODS
  def self.get_type_field_options
    options = ['Monto','Cantidad','Sumar al final','Ignorar']
    return options
  end
  def self.get_type_value_options
    options = ['Entero','Decimal']
    return options
  end

  def self.get_header_array
    header = ['Número']
    self.order(:order).each do |h|
      header << h.short_name
    end
    header.pop(2)
    return header
  end
end
