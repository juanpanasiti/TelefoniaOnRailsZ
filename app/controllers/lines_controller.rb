class LinesController < ApplicationController
  before_action :set_line, only: [:edit, :update, :destroy]
  before_action :options_for_select, only: [:new, :create, :edit, :update]
  before_action :set_has_menu
  def index
    @lines = Line.all
  end

  def new
    @line = Line.new
    @le_titule = "Nueva línea"
  end
  def create
    @line = Line.new(line_params)

    respond_to do |format|
      if @line.save
        format.html { redirect_to cellphones_lines_path, notice: 'Línea agregada a la flota.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @le_titule = "Editar #{@line.number}"
    #code
  end
  def update
    respond_to do |format|
      if @line.update(line_params)
        format.html { redirect_to cellphones_lines_path, notice: 'Datos de la línea actualizados.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @line.destroy
    respond_to do |format|
      format.html { redirect_to cellphones_lines_path, alert: 'Línea eliminada.' }
    end
  end

  def control_csv
    full_csv = Line.get_full_table(params[:archivo_csv].path)

    @table = full_csv
  end

  def control_gcontacts
    full_csv = Line.get_gcontacts_table(params[:archivo_csv].path)
    @lines_to_check = Line.compare_with_google(params[:archivo_csv].path)
    @has_menu = false
    @tab_body = full_csv
  end

  protected
  def set_line
    @line = Line.find(params[:id])
  end

  def line_params
    params.require(:line).permit(:number, :person_id, :has_inet, :state, :type_sim, :has_sms_pack, :check_date, :notes, :bill_account, :vpn_link, :limit_offnet, :clarification, :plan_id)
  end

  def options_for_select
    @has_inet_options = Line.get_has_inet_options
    @state_options = Line.get_state_options
    @type_sim_options = Line.get_type_sim_options
    @bill_account_options = Line.get_bill_account_options
    @users_options = Person.get_users_options
    @plan_options = Plan.get_plan_options
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
