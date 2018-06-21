class PlansController < ApplicationController
  before_action :set_plan, only: [:edit, :update, :destroy]
  before_action :options_for_select, only: [:new, :create, :edit, :update]
  before_action :set_has_menu

  def new
    @plan = Plan.new
    @le_titule = "Nuevo plan"
  end
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to cellphones_plans_path, notice: 'Plan cargado correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    #code
    @le_titule = "Editar plan #{@plan.name}"
  end
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to cellphones_plans_path, notice: 'Datos del plan actualizados.' }
      else
        format.html { render :edit }
      end
    end
  end #update

  def destroy
    if @plan.is_destroyable?
      @plan.destroy
      redirect_to cellphones_plans_path, alert: 'Plan eliminado.'
    else
      redirect_to cellphones_plans_path, alert: 'El plan tiene líneas asociadas, no se puede eliminar.'
    end
  end #destroy

  protected
  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :normal_price, :roaming, :offnet_pack, :onnet_pack, :inet_pack, :credit, :sms_pack, :kind, :details)
  end

  def options_for_select
    @kind_options = Plan.get_kind_options
    @roaming_options = Plan.get_roaming_options
    @inet_pack_options = Plan.get_inet_pack_options
    @minutes_pack_options = Plan.get_minutes_pack_options
    @sms_pack_options = Plan.get_sms_pack_options
  end

  def set_has_menu
    @has_menu = true
    case action_name
    when "new", 'create', 'edit', 'update', 'control_csv'
      @has_menu = false
    else
      @has_menu = true
    end
  end
end
