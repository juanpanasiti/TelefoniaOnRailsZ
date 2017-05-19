class BillHeadersController < ApplicationController
  before_action :set_header, only: [:edit, :update]
  before_action :options_for_select, only: [:new, :create, :edit, :update]
  def new
    @header = BillHeader.new
  end
  def create
    @header = BillHeader.new(bill_header_params)
    respond_to do |format|
      if @header.save
        format.html { redirect_to settings_path(section:'billing'), notice: 'Nueva Columna de tabla agregada.' }
      else
        format.html { render :new }
      end
    end
  end
  def edit

  end
  def update
    respond_to do |format|
      if @header.update(bill_header_params)
        format.html { redirect_to settings_path(section:'billing'), notice: 'Datos de la Columna de tabla actualizados.' }
      else
        format.html { render :edit }
      end
    end
  end

  protected
  def set_header
    @header = BillHeader.find(params[:id])
  end

  def bill_header_params
    params.require(:bill_header).permit(:name, :short_name, :order, :type_value, :type_field)
  end

  def options_for_select
    @header_type_field = BillHeader.get_type_field_options
    @header_type_value = BillHeader.get_type_value_options
  end

end
