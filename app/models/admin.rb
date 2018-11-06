class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
############# SCOPES
scope :superadmins, -> { where(access_level: 3) }
############# INSTANCE METHODS
  def reset_pass
    self.password = "12345678"
    return self.save
  end

  def change_access(new_lvl)
    self.access_level = new_lvl
    return self.save
  end
end
