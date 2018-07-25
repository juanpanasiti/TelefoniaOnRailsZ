class Document
  include ActiveModel::Model
  # Equipo entregado
  attr_accessor :giving_number, :name, :lastname, :dni, :office, :aclaration, :device_model, :device_imei, :line, :device_state, :accesories, :configured_by, :date
  #Equipo devuelto/robado/perdido
  attr_accessor :dr_condition, :dr_model, :dr_imei, :dr_state, :dr_date, :dr_aclaration, :dr_accesories_returned
  #Equipos anteriores
  attr_accessor :previous_devices
end
