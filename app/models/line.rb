class Line < ApplicationRecord
  ########## RELATIONS
  belongs_to :person, optional: true
  belongs_to :plan, optional: true
  has_one :device
  ########## VALIDATES
  validates_presence_of :number, :bill_account, :state, :type_sim, :plan_id
  validates_uniqueness_of :number
  validates :number, length: { is: 10 }


  ########## SCOPES
  scope :current_lines, -> { where.not(state: 'Baja (Titularidad)').where.not(state: 'Baja (Cambio núm.)')  }
  scope :for_service, -> { where('state = ? OR state = ?', 'Preparación/revisión', 'Esperando SIM' )}
  scope :check_status, -> { where(state: 'Revisar estado!')}
  scope :in_use, -> { where(state: 'Activa')}
  scope :saved, -> { where(state: 'Guardada')}
  scope :on_loan, -> { where(state: 'Prestada')}
  ########## METHODS
  def get_formated_number
    number = self.number.insert(6,'-').insert(3,')').insert(0,'(')
    return number
  end
  def get_plan
    plan_name = 'No definido'
    if self.plan.present?
      plan_name = self.plan.name
    end
    return plan_name
  end

  def check_today
    #Refactor 09-2018
    self.check_date = Date.today
    self.save
  end

  def get_device
    # Devuevle el equipo registrado en sistema asociado a la linea
    device = Device.where(line_id: self.id).first
    if device.blank?
      device = Device.new
    end
    return device
  end
  def get_user_full_name
    if self.id.nil?
      name = "No cargado en DB"
    else
      if self.person.present?
        name = self.person.get_full_name
      else
        name = 'Sin asignar'
      end
    end
    unless self.clarification.blank?
      name = name + " (#{self.clarification})"
    end
    return name
  end
  def get_row_table_class
    row_class = case self.state
      when 'Activa' then 'table-success'
      when 'Guardada' then 'table-primary'
      when 'Preparación/revisión' then 'table-dark'
      when 'Esperando SIM' then 'table-warning'
      when 'Solicitar SIM' then 'bg-warning'
      when 'Prestada' then 'table-secondary'
      when 'Baja (Titularidad)' then 'bg-danger'
      when 'Baja (Cambio núm.)' then 'bg-danger'
      when 'Revisar estado!' then 'table-danger'
      else 'table-light'
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
    when 'Solicitar SIM'
      'warning'
    when 'Prestada'
      'default'
    when 'Baja (Titularidad)'
      'danger'
    when 'Baja (Cambio núm.)'
      'danger'
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

  def get_device_name
    device = self.get_device
    unless device.nil? || device.device_model.nil?
      return device.get_device_name
    else
      return "Sin Equipo asociado"
    end
  end

  def get_principal_office_name
    oficina = ''
    if self.person.present?
      if self.person.office.present?
        self.person.office.get_name
      else
        "S/D"
      end
    else
      "S/D"
    end
  end
  ########## CLASS METHODS
  def self.get_full_table(url_csv)
    csv_text = File.read(url_csv, :encoding => 'ISO8859-1').gsub(/\r/, '').gsub('"','') #quitar caracteres
    csv_text = csv_text.split("\n")
    csv_table = []
    total = 0
    csv_text.each do |row|
      row = row.split(';')
      row.delete_at(2)
      csv_table << row
    end
    header_table = csv_table.shift #Original_Header
    body_table = csv_table #Body
		return [header_table,body_table,total.round(2)]
    #return csv_text
  end

  def self.compare_with_google(url_csv)
    google_contacts = self.get_gcontacts_table(url_csv) #Arreglo de duplas [Nombre,Numero]
    lines = self.get_array_line_number
    lines.each_with_index do |line,index|
      google_contacts.each_with_index do |gc, i|
        if gc[1] == line[1]
          line << gc[0] << gc[1]
          google_contacts.delete_at(i)
          break
        end
      end
    end

    return lines
  end

  def self.get_array_line_number
    #[get_user_full_name,number,state]
    csv_table = []
    Line.all.each do |line|
      csv_table << [line.get_user_full_name, line.number, line.state]
    end
    return csv_table
  end

  def self.get_gcontacts_table(url_csv)
    csv_text = File.read(url_csv)
    csv_text = csv_text.split("\n")
    csv_table = []
    csv_text.each do |row|
      row = row.split(',')
      csv_table << [row[0], format_cell_number(row[37])]
    end
    header_table = csv_table.shift #Original_Header
    body_table = csv_table #Body
		return body_table
    #return csv_text
  end

  def self.get_no_data_option
    #Opcion común a casi todos los selectores
    return ['S/D', 'no_data']
  end

  def self.get_has_inet_options
    # Devuelve las opciones para los tipos de paquetes de datos
    options = ['S/D','Sin Pack de Datos','Pack Smart. 1Gb','Pack Smart. 3Gb','Pack Smart. 5Gb','Pack Smart. 10Gb','M2M 25Mb','Pack Smartphone','Pack BlackBerry']
    return options
  end

  def self.get_state_options
    # Devuelve la lista de opciones para los estados que puede tomar una línea
    options = ['S/D','Activa','Guardada','Preparación/revisión','Esperando SIM','Solicitar SIM','Prestada','Baja (Titularidad)','Baja (Cambio núm.)','Revisar estado!']
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

  def self.find_by_number(number)
    #Devuelve un objeto Line correspondiente al número de línea
    line = Line.where(number: number).first
    if line.blank?
      line = Line.new
    end
    return line
  end
end
