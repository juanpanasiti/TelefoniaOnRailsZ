class DeviceModel < ApplicationRecord
  ########## VALIDATES
  validates_presence_of :mark, :device_name, :type_sim, :category
  validates_uniqueness_of :device_code
  ########## METHODS
  def get_full_model_name
    #Devuelve el nombre completo del modelo
    name = "#{self.mark.upcase} #{self.device_name}" + (self.device_code.nil? ? '' : " (#{self.device_code})")
  end
  ########## CLASS METHODS
  def self.get_mark_options
    marks = ['Motorola','Samsung','Nokia','LG','BlackBerry','iPhone','Huawei','Alcatel','Sony','Microsoft','DESCONOCIDA','Otra Marca']
    return marks
  end
  def self.get_band_options
    bands = ['4G','3G','2G','S/D']
    return bands
  end
  def self.get_os_options
    oss = ['Android','Windows','iOS','Propietario','Otro']
    return oss
  end
  def self.get_category_options
    categories = ['Smartphone','Celular Común','Modem/Router','Telular','Otro tipo']
    return categories
  end
  def self.get_type_sim_options
    types = ['Micro SIM','Nano SIM','SIM Común','S/D']
  end
end
