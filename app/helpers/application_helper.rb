module ApplicationHelper
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
        time_ago << "Hace #{days} días"
      end
      return time_ago
    end
  end # END_calculate_time_ago
end
