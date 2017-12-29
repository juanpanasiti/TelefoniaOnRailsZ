class CellphonesController < ApplicationController
  before_action :set_has_menu
  def lines
    @le_titule = "Líneas"
    @lines = Line.current_lines
  end

  def devices
    @le_titule = "Equipos"
  end

  def models
    @le_titule = "Modelos de equipos"
  end
protected
  def set_has_menu
    @has_menu = true
  end
end
