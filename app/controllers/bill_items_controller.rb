class BillItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update]
  before_action :options_for_select, only: [:new, :create, :edit, :update]
  def new
    @item = BillItem.new
  end
  def create
    @item = BillItem.new(bill_item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to settings_path(section:'billings'), notice: 'Nueva Columna de tabla agregada.' }
      else
        format.html { render :new }
      end
    end
  end
  def edit

  end
  def update
    respond_to do |format|
      if @item.update(bill_item_params)
        format.html { redirect_to settings_path(section:'billings'), notice: 'Datos de la Columna de tabla actualizados.' }
      else
        format.html { render :edit }
      end
    end
  end

  def charge_new_items_csv
    full_csv = Billing.get_full_table(params[:archivo].path)
    # @uncharged_items = BillItem.get_uncharged_items(full_csv[1])
    charged = BillItem.charge_new_items(BillItem.get_uncharged_items(full_csv[1]))
    respond_to do |format|
      if charged
        format.html { redirect_to settings_path(section:'billings'), notice: 'Se agregaron todos los items.' }
      else
        format.html { redirect_to settings_path(section:'billings'), alert: 'Quedaron items sin cargar.' }
      end
    end
  end

  protected
  def set_item
    @item = BillItem.find(params[:id])
  end

  def bill_item_params
    params.require(:bill_item).permit(:bill_header_id,:concept_id,:concept_description,:quantity_column)
  end

  def options_for_select
    @item_header_options = BillItem.get_header_options
    @item_quantity_column = BillItem.get_quantity_columns_options
  end
end
