class SelectorSettingsController < ApplicationController
  before_action :set_selector_setting, only: [:edit, :update, :delete]
  before_action :options_for_selects, only: [:new, :create, :edit, :update]

  def index
    @selector_settings = SelectorSetting.all
  end
  def new
    @selector_setting = SelectorSetting.new
  end
  def create
    @selector_setting = SelectorSetting.new(selector_setting_params)

    respond_to do |format|
      if @selector_setting.save
        format.html { redirect_to selector_settings_path, notice: 'Nueva opción agregada a selectores.' }
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
      if @selector_setting.update(selector_setting_params)
        format.html { redirect_to selector_settings_path, notice: 'Opción editada.' }
      else
        format.html { render :edit }
      end
    end
  end

  def delete
    @selector_setting.destroy
    respond_to do |format|
      format.html { redirect_to selector_settings_path, notice: 'Opción eliminada de selectores.' }
    end
  end

  protected
  def set_selector_setting
    @selector_setting = SelectorSetting.find(params[:id])
  end

  def selector_setting_params
    params.require(:selector_setting).permit(:name, :id_name, :selector)
  end

  def options_for_selects
    @selector_options = SelectorSetting.get_selector_options

  end
end
