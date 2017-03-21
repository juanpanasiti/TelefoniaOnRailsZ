class SettingsController < ApplicationController
  #before_action :set_selector_setting, only: [:edit, :update, :delete]
  before_action :options_for_selects, only: [:new_selector, :create_selector]
  def index
    @selector_settings = SelectorSetting.all
    @offices = Office.all
    @delegations = Delegation.all
  end

  def new_selector
    @selector_setting = SelectorSetting.new
  end
  def create_selector
    @selector_setting = SelectorSetting.new(selector_setting_params)

    respond_to do |format|
      if @selector_setting.save
        format.html { redirect_to settings_path, notice: 'Nueva opción agregada a selectores.' }
      else
        format.html { render :new }
      end
    end
  end

  protected
  def selector_setting_params
    params.require(:selector_setting).permit(:name, :id_name, :selector)
  end

  def options_for_selects
    @selector_options = SelectorSetting.get_selector_options
  end

  #def set_selector_setting
  #  @selector_setting = SelectorSetting.find(params[:id])
  #end
end
