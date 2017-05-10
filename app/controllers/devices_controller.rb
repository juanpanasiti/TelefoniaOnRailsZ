class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def show
  end

  def new
    @device = Device.new
  end

  def edit
  end

  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to settings_path(section:'devices'), notice: 'Device was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to settings_path(section:'devices'), notice: 'Device was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to settings_path(section:'devices'), notice: 'Device was successfully destroyed.' }
    end
  end

  private
  def options_for_select
    @line_options = Device.get_line_options
    @model_options = Device.get_model_options
    @state_options = Device.get_state_options
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:device_model_id, :imei, :line_id, :is_personal, :state, :failure, :check_date, :details)
    end
end
