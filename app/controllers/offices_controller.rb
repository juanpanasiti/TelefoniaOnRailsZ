class OfficesController < ApplicationController
  before_action :set_office, only: [:edit, :update, :delete]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def new
    @office = Office.new
  end
  def create
    @office = Office.new(office_params)

    respond_to do |format|
      if @office.save
        format.html { redirect_to settings_path(section:'offices'), notice: 'Nueva Oficina agregada.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    #code
  end
  def update
    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to settings_path(section:'offices'), notice: 'Datos de la oficina actualizados.' }
      else
        format.html { render :edit }
      end
    end
  end

  def delete
    @office.destroy
    respond_to do |format|
      format.html { redirect_to settings_path(section:'offices'), notice: 'Oficina eliminada.' }
    end
  end

  protected
  def set_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.require(:office).permit(:name, :footnote, :parent_id, :delegation_id)
  end

  def options_for_select
    @office_parent_options = Office.get_parent_options
    @office_delegation_options = Office.get_delegation_options
  end
end
