class Device < ApplicationRecord
  belongs_to :device_model
  belongs_to :line, optional: true
  ########## VALIDATES
  validates_presence_of :imei, :state, :device_model_id
  validates_uniqueness_of :imei
  validates :imei, length: { is: 15, message: "Deben ser 15 números." }
  ############## CALLBACKS
  before_save :clean_lines_asociated#, if: 'line_id.nil?'
  ############## CALLBACKS METHODS
  def clean_lines_asociated
    if self.line.present?
      line = self.line_id
      devs = Device.where(line_id: line)
      devs.each do |dev|
        unless dev.id == self.id
          dev.line_id = nil
          dev.save
        end
      end
    end
  end
  ########## METHODS
  def get_imei
    #Devuelve el IMEI con formato ######-##-######-#
    return self.imei.insert(14,'-').insert(8,'-').insert(6  ,'-')
  end
  def get_line
    #Devuelve el número de línea en caso de estar asociado a una
    return self.line.present? ? self.line.number : ''
  end
  def get_device_name
    return "#{self.device_model.get_full_model_name} ~#{self.imei.last(5)}"
  end
  def get_full_model_name
    name = ''
    unless self.device_model.blank?
      name = self.device_model.get_full_model_name
    end
    return name
  end
  ########## CLASS METHODS
  def self.get_line_options
    lines = []
    Line.all.each do |line|
      lines << ["#{line.number} - #{line.get_user_full_name}", line.id]
    end
    return lines.sort
  end
  def self.get_model_options
    models = []
    DeviceModel.all.each do |model|
      models << [model.get_full_model_name, model.id]
    end
    return models.sort
  end
  def self.get_state_options
    states = ['En uso','Para retirar (usuario)','Nuevo (Guardado)','Usado (Guardado)','Para revisión','En Service','Para repuesto', 'Baja (robo o pérdida)']
  end
end
