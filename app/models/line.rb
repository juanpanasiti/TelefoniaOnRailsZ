class Line < ApplicationRecord
  belongs_to :person, optional: true
  has_one :device
  validates_presence_of :number, :bill_account, :state, :type_sim
  validates_uniqueness_of :number
  validates :number, length: { is: 10 }


  ########## SCOPES
  scope :current_lines, -> { where.not(state: 'Baja (Titularidad)').where.not(state: 'Baja (Cambio núm.)')  }
  ########## METHODS
  def get_user_full_name
    if self.person.present?
      name = self.person.get_full_name
    else
      name = 'Sin asignar'
    end
    unless self.clarification.blank?
      name = name + " (#{self.clarification})"
    end
    return name
  end
  def get_row_table_class
    row_class = case self.state
      when 'Activa' then 'bg-success'
      when 'Guardada' then 'bg-info'
      when 'Preparación/revisión' then 'bg-warning'
      when 'Esperando SIM' then 'bg-warning'
      when 'Prestada' then 'bg-default'
      when 'Baja (Titularidad)' then 'bg-default'
      when 'Baja (Cambio núm.)' then 'bg-default'
      when 'Revisar estado!' then 'bg-danger'
      else 'default'
    end
    return row_class

  end
  def get_badge_class_to_state
    badge_class = case self.state
    when 'Activa'
      'success'
    when 'Guardada'
      'info'
    when 'Preparación/revisión'
      'warning'
    when 'Esperando SIM'
      'warning'
    when 'Prestada'
      'default'
    when 'Baja (Titularidad)'
      'default'
    when 'Baja (Cambio núm.)'
      'default'
    when 'Revisar estado!'
      'danger'
    else
      'default'
    end
    return badge_class
  end

  def check_date_formatted
    #Devuelve la fecha del último check con formato dd-mm-yyyy
    date = '!!!'
    unless self.check_date.blank?
      date = self.check_date.strftime("%d-%m-%y")
    end
    return date
  end
  ########## CLASS METHODS
  def self.get_full_table(url_csv)
    csv_text = File.read(url_csv, :encoding => 'ISO8859-1').gsub(/\r/, '').gsub('"','') #quitar caracteres
    csv_text = csv_text.split("\n")
    csv_table = []
    total = 0
    csv_text.each do |row|
      row = row.split('|')
      row.delete_at(2)
      csv_table << row
    end
    header_table = csv_table.shift #Original_Header
    body_table = csv_table #Body
		return [header_table,body_table,total.round(2)]
    #return csv_text
  end


  def self.get_no_data_option
    #Opcion común a casi todos los selectores
    return ['S/D', 'no_data']
  end

  def self.get_has_inet_options
    # Devuelve las opciones para los tipos de paquetes de datos
    options = ['S/D','Sin Pack de Datos','Pack Smart. 1Gb','Pack Smart. 3Gb','Pack Smart. 5Gb','Pack Smart. 10Gb','Pack Smartphone','Pack BlackBerry']
    return options
  end

  def self.get_state_options
    # Devuelve la lista de opciones para los estados que puede tomar una línea
    options = ['S/D','Activa','Guardada','Preparación/revisión','Esperando SIM','Prestada','Baja (Titularidad)','Baja (Cambio núm.)','Revisar estado!']
    return options
  end

  def self.get_type_sim_options
    # Devuelve la lista de opciones para los tipos de tarjeta SIM
    options = ['S/D','Trio','Duo','Nano','Micro SIN nano','Micro CON nano','Duo/Micro 3G','SIM Vieja 2G/3G']
    return options
  end

  def self.get_bill_account_options
    # Devuelve la lista de opciones con los número de cuenta
    options = ['S/D','379408685','379741424','Línea Externa']
    return options
  end
end
