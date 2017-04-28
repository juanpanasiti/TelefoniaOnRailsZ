class LinesController < ApplicationController
  before_action :set_line, only: [:edit, :update, :delete]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def new
    @line = Line.new
  end
  def create
    @line = Line.new(line_params)

    respond_to do |format|
      if @line.save
        format.html { redirect_to root_path(section: 'lines'), notice: 'Line was successfully created.' }
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
      if @line.update(line_params)
        format.html { redirect_to root_path(section: 'lines'), notice: 'Line was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def delete
    @line.destroy
    respond_to do |format|
      format.html { redirect_to root_path(section: 'lines'), notice: 'Line was successfully destroyed.' }
    end
  end

  protected
  def set_line
    @line = Line.find(params[:id])
  end

  def line_params
    params.require(:line).permit(:number, :person_id, :has_inet, :state, :type_sim, :has_sms_pack, :check_date, :notes, :bill_account, :vpn_link, :limit_offnet)
  end

  def options_for_select
    @has_inet_options = Line.get_has_inet_options
    @state_options = Line.get_state_options
    @type_sim_options = Line.get_type_sim_options
    @bill_account_options = Line.get_bill_account_options
    @users_options = Person.get_users_options


  end
end
