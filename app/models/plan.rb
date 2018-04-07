class Plan < ApplicationRecord
  ######## RELATIONS
  has_many :lines
  ######## VALIDATES
  validates_presence_of :name, :normal_price, :roaming, :offnet_pack, :onnet_pack, :sms_pack, :inet_pack, :credit, :kind
  validates_uniqueness_of :name
  ######## CALLBACKS

  ######## OBJECTS METHODS
  def is_destroyable?
    if self.lines.count > 0
      return false
    else
      return true
    end
  end
  ######## CLASS METHODS
  def self.get_kind_options
    return ['Factura fija (control)', 'Abono Libre', 'Otro plan']
  end

  def self.get_roaming_options
    return ['Si, sin beneficios', 'Uruguay y Paraguay', 'Plan América', 'Sin Roaming']
  end

  def self.get_inet_pack_options
    return ['25Mb', '50Mb', '3Gb', '5Gb', '10Gb', 'Sin pack']
  end

  def self.get_minutes_pack_options
    return ['0', '100', '3.000', '5.000', '10.000']
  end

  def self.get_sms_pack_options
    return ['0', '25', '100', '1.000', '10.000']
  end

  def self.get_plan_options
    options = []
    Plan.all.each do |p|
      options << [p.name, p.id]
    end
    return options
  end
end
