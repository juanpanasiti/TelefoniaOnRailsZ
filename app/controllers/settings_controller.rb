class SettingsController < ApplicationController
  def index
    @selector_settings = SelectorSetting.all
    @offices = Office.all
    @delegations = Delegation.all
    @device_models = DeviceModel.all
    @devices = Device.all

    @section = params[:section]
    @position = case @section
      when 'offices'
        0
      when 'devices'
        1
      when 'billing'
        2
      else
        0
    end
  end
end
