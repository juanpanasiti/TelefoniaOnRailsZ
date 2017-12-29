module ApplicationHelper
  def formated_date date
    formated = 'S/D'
    unless date.nil?
      formated = "#{date.mday}-#{date.month}-#{date.year}"
    end
    return formated
  end
  def calculate_time_ago(past)
    if past.nil?
      return "Revisar!"
    else
      days = (Time.current.to_date - past.to_date).to_i

      time_ago = ""
      if days == 0
        time_ago << "Hoy"
      elsif days == 1
        time_ago << "Ayer"
      else
        time_ago << "-#{days}d"
      end
      return time_ago
    end
  end # END_calculate_time_ago

  def calculate_time_ago_large(past)
    if past.nil?
      return "Revisar!"
    else
      days = (Time.current.to_date - past.to_date).to_i

      time_ago = ""
      if days == 0
        time_ago << "Hoy"
      elsif days == 1
        time_ago << "Ayer"
      else
        time_ago << "Hace #{days} días"
      end
      return time_ago
    end
  end # END_calculate_time_ago_large

  def true_or_false_to_icon bool
    if bool
      icon = '<i class="fa fa-check be-green" aria-hidden="true"></i>'
    else
      icon = '<i class="fa fa-times be-red" aria-hidden="true"></i>'
    end
    return icon.html_safe
  end # END_true_or_false_to_icon

  def show_failures failure_detail
    if failure_detail.empty?
      return "<span class='badge badge-success'><i class='fa fa-check-square-o' aria-hidden='true'></i> Ninguna</span>".html_safe
    else
      return failure_detail
    end

  end

  def correct_table_number cell
    if cell.to_s == '0.0' || cell.nil?
      return ''
    else
      return cell.to_f.round(2).to_s.gsub('.',',')
    end
  end

  def abreviate_names str
    abreviations = [
      ['Subdirección', 'Subdir.'],
      ['General', 'Gral.'],
      ['Administración', 'Admin.'],
      ['Departamento', 'Dpto.'],
      ['División', 'Div.'],
      ['Secretaría', 'Secr.'],
      ['Inspección', 'Insp.'],
      ['Fiscalización', 'Fisc.'],
      ['Casa Municipal', 'Casa Muni.'],
      ['Honorable Concejo Deliberante', 'H.C.D.'],
      ['Bloque', 'Bl.'],
      ['Servicios Públicos', 'Serv. Púb.'],
      ['Transporte, Monitoreo Y Control', 'Transp. Mon. y Ctrl.'],
      ['Dirección', 'Dir.']
    ]
    abreviations.each do |ab|
      if str.include? ab[0]
        str[ab[0]] = ab[1]
      end
    end
    return str
  end
end# END_MODULE
