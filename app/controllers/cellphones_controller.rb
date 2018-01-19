class CellphonesController < ApplicationController
  layout :resolve_layout
  before_action :set_has_menu

  def lines
    @le_titule = "Líneas"
    @lines = Line.current_lines
  end

  def devices
    @le_titule = "Equipos"
    @devices = Device.all
  end

  def models
    @le_titule = "Modelos de equipos"
    @device_models = DeviceModel.all
  end

  def show_device
    @device = Device.find(params[:id])
  end

  def show_line
    @line = Line.find(params[:id])
  end

  def show_report
    @le_titule = "Reporte cta ~685"
    @lines = Line.current_lines.where(bill_account: params[:account]).order(:number)
  end
protected
  def set_has_menu
    @has_menu = true
  end

  def resolve_layout
    case action_name
    when "show_report"
      "blank_layout"
    else
      "application"
    end
  end
end
