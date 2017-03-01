class Person < ApplicationRecord
  has_many :lines

  ########## METHODS
  def get_full_name
    # Devuelve el nombre completo en formato 'APELLIDO, Nombre1 Nombre2'
    full_name = "#{self.lastname.upcase}, #{self.name}"
    return full_name
  end
  def get_dni_formated
    # Devuelve el DNI en formato ##.###.###
    dni = self.dni.reverse.insert(3,'.').insert(7,'.').reverse
    return dni
  end
end
