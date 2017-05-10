class DeviceModelsController < ApplicationController
  before_action :set_device_model, only: [:show, :edit, :update, :destroy]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def show
  end

  def new
    @device_model = DeviceModel.new
  end

  def edit
  end

  def create
    @device_model = DeviceModel.new(device_model_params)

    respond_to do |format|
      if @device_model.save
        format.html { redirect_to settings_path(section:'devices'), notice: 'Device model was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @device_model.update(device_model_params)
        format.html { redirect_to settings_path(section:'devices'), notice: 'Device model was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @device_model.destroy
    respond_to do |format|
      format.html { redirect_to settings_path(section:'devices'), notice: 'Device model was successfully destroyed.' }
    end
  end

  private

    def options_for_select
      #Opciones que aparecen en las listas desplegables del formulario (new y edit)
      @mark_options = DeviceModel.get_mark_options
      @category_options = DeviceModel.get_category_options
      @os_options = DeviceModel.get_os_options
      @band_options = DeviceModel.get_band_options
      @type_sim_options = DeviceModel.get_type_sim_options
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_device_model
      @device_model = DeviceModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_model_params
      params.require(:device_model).permit(:mark, :device_name, :device_code, :accessories, :details, :type_sim, :specs_link, :slot_sd, :category, :band, :os)
    end
end
