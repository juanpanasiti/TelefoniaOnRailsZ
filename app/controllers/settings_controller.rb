class SettingsController < ApplicationController
  #before_action :set_selector_setting, only: [:edit, :update, :delete]
  before_action :options_for_selects, only: [:new_selector, :create_selector,:new_office, :create_office]
  before_action :set_new_delegation, only: [:index, :new]
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
        format.html { render :new_selector }
      end
    end
  end

  def new_office
    @office = Office.new
  end
  def create_office
    @office = Office.new(office_params)

    respond_to do |format|
      if @office.save
        format.html { redirect_to settings_path, notice: 'Nueva Oficina agregada.' }
      else
        format.html { render :new_office }
      end
    end
  end

  def new_delegation
  end
  def create_delegation
    @delegation = Delegation.new(delegation_params)

    respond_to do |format|
      if @delegation.save
        format.html { redirect_to settings_path, notice: 'Nueva Oficina agregada.' }
        format.js
      else
        format.html { render :new_delegation }
      end
    end
  end
  protected
  def selector_setting_params
    params.require(:selector_setting).permit(:name, :id_name, :selector)
  end
  def office_params
    params.require(:office).permit(:name, :parent_id, :delegation_id)
  end
  def delegation_params
    params.require(:delegation).permit(:name, :address, :footnote)
  end

  def options_for_selects
    @selector_options = SelectorSetting.get_selector_options
    @office_parent_options = Office.get_parent_options
    @office_delegation_options = Office.get_delegation_options
  end

  def set_new_delegation
      @delegation = Delegation.new
    end

  #def set_selector_setting
  #  @selector_setting = SelectorSetting.find(params[:id])
  #end
end
