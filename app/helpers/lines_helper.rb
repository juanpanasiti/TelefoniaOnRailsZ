module LinesHelper
  def get_class_to_registered_imei(reg_imei,act_imei,sys_imei)
    css_class = ''
    if reg_imei == act_imei && act_imei == sys_imei && reg_imei == sys_imei
      css_class = 'table-success'
    else
      css_class = 'table-warning'
    end

  end
end
