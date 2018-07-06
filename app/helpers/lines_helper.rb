module LinesHelper
  def get_class_to_registered_imei(reg_imei,act_imei,sys_imei)
    css_class = ''
    if reg_imei == act_imei && act_imei == sys_imei && reg_imei == sys_imei
      css_class = 'table-success'
    else
      css_class = 'table-warning'
    end
    return 'table-warning'
  end #get_class_to_registered_imei

  def get_class_alert_imei(reg_imei, check_imei)
    css_class = ''
    if reg_imei == check_imei
      css_class = 'success-text'
    else
      css_class = 'alert-text'
    end
    return css_class
  end
end
