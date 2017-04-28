class Person < ApplicationRecord
  has_many :lines
  belongs_to :office, optional: true

  ########## VALIDATIONS
  validates_presence_of :name, :lastname
  validates_uniqueness_of :name, :lastname
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
  ########## CLASS METHODS
  def self.get_users_options
    users = []
    self.all.each do |user|
      users << ["#{user.get_full_name} (#{user.lines.count})",user.id]
    end
    return users
  end
end
