class InternalsController < ApplicationController
  before_action :set_internal, only: [:edit, :update, :destroy, :show]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def index
    @internals = Internal.all
  end #index

  def show
    #code
  end

  def new
    @internal = Internal.new
  end #new
  def create
    @internal = Internal.new(internal_params)

    respond_to do |format|
      if @internal.save
        format.html { redirect_to internals_path, notice: 'Línea interna agregada a la flota.' }
      else
        format.html { render :new }
      end
    end
  end #create

  def edit
    #code
  end
  def update
    respond_to do |format|
      if @internal.update(internal_params)
        format.html { redirect_to internals_path, notice: 'Datos de la línea interna actualizados.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @internal.destroy
    respond_to do |format|
      format.html { redirect_to internals_path, alert: 'Línea interna eliminada.' }
    end
  end #destroy

  protected
  def set_internal
    @internal = Internal.find(params[:id])
  end #set_internal

  def internal_params
    params.require(:internal).permit(:name, :prefix, :number, :footNote, :office_id, :kind, :aclaration, :service_required)
  end #internal_params

  def options_for_select
    @office_options = Office.get_detailed_list
    @kind_options = Internal.get_kind_line_options
  end #options_for_select
end
