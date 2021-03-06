class OfficesController < ApplicationController
  before_action :set_office, only: [:edit, :update, :destroy]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def index
    @le_titule = "Oficinas"
    @offices = Office.all
  end
  def new
    @office = Office.new
    @le_titule = "Nueva Oficina"
  end
  def create
    @office = Office.new(office_params)
    respond_to do |format|
      if @office.save
        format.html { redirect_to offices_path, notice: 'Nueva Oficina agregada.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @le_titule = "Editar"
    #code
  end
  def update
    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to offices_path, notice: 'Datos de la oficina actualizados.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @office.destroy
    respond_to do |format|
      format.html { redirect_to offices_path, notice: 'Oficina eliminada.' }
    end
  end

  protected
  def set_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.require(:office).permit(:name, :footnote, :parent_id, :category)
  end

  def options_for_select
    @office_parent_options = Office.get_parent_options
    @office_category_options = Office.get_category_options
  end
end
