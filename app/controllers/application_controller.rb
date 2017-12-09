class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_signed_in

  def check_signed_in
    lvl_1_permitted = ['errors/access_denied', 'home/index']
    lvl_2_permitted = ['errors/access_denied', 'home/index', 'settings/index']
    if not(admin_signed_in?)
      authenticate_admin!
    elsif current_admin.access_level == 0 && controller_name != 'errors' #Sin acceso
      redirect_to errors_access_denied_path
    elsif current_admin.access_level == 1
      unless (lvl_1_permitted.include? (controller_name.to_s + '/' + action_name))
        redirect_to errors_access_denied_path
      end
    elsif current_admin.access_level == 2
      unless (lvl_2_permitted.include? (controller_name.to_s + '/' + action_name))
        redirect_to errors_access_denied_path
      end
    end
  end
end
