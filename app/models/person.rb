class Person < ApplicationRecord
  has_many :lines
  has_many :devices, through: :lines
  has_many :mail_accounts, inverse_of: :person
  accepts_nested_attributes_for :mail_accounts, reject_if: :all_blank, allow_destroy: true
  belongs_to :office, optional: true

  ########## VALIDATIONS
  validates_presence_of :name, :lastname
  ########## METHODS
  def get_full_name
    # Devuelve el nombre completo en formato 'APELLIDO, Nombre1 Nombre2'
    full_name = "#{self.lastname.upcase}, #{self.name}"
    return full_name
  end
  def get_dni_formated
    # Devuelve el DNI en formato ##.###.###
    if self.dni.present?
      dni = self.dni.reverse.insert(3,'.').insert(7,'.').reverse
    else
        dni = ''
    end
    return dni
  end
  def get_office_full_name
    if self.office.present?
      return self.office.get_full_name
    else
      return 'S/D'
    end
  end
  def get_office_short_name
    if self.office.present?
      return self.office.get_short_name
    else
      return 'S/D'
    end
  end
  def get_lines_devices_count
    return "#{self.lines.count}/#{self.devices.count}"
  end
  def get_emails
    return self.mail_accounts
  end
  def get_lines
    return self.lines
  end
  ########## CLASS METHODS
  def self.get_users_options
    users = []
    self.all.each do |user|
      users << ["#{user.get_full_name} (#{user.lines.count})",user.id]
    end
    return users.sort
  end
end
