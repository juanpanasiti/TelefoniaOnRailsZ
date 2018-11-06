class AdminzoneController < ApplicationController
  before_action :check_access, only: [:index]
  before_action :set_admin, only: [:reset_pass, :change_access]
  def index
    @le_titule = "AdminZone"
    @admins = Admin.all
    @superadmins = Admin.superadmins
  end

  def change_access
    if @admin.change_access(params[:new_lvl])
      redirect_to adminzone_index_path, notice: "Nivel de usuario cambiado a #{params[:new_lvl]}"
    else
      redirect_to adminzone_index_url, alert: "Error al cambiar de nivel de acceso"
    end
  end
  def reset_pass
    if @admin.reset_pass
      redirect_to adminzone_index_path, notice: "Contraseña reseteada a 12345678"
    else
      redirect_to adminzone_index_url, alert: "Error al resetear contraseña"
    end
  end
private
  def check_access
    if current_admin.access_level < 3
      redirect_to root_url
    end
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
