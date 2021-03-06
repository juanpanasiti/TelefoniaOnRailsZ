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
    reg = reg_imei.to_s.strip
    check = check_imei.to_s.strip
    css_class = ''
    if reg == check
      css_class = 'success-text'
    else
      css_class = 'alert-text'
    end
    return css_class
  end
end

def format_cell_number(number)
  corrected = ''
  unless number.nil?
    corrected = number.gsub(' ','').gsub('-','').gsub('+549','')
    if corrected.start_with?('549')
      corrected = corrected.slice(3,corrected.length)
    end
  end
  return corrected
end
