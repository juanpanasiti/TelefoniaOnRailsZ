class SettingsController < ApplicationController
  def index
    @has_menu = true
    @le_titule = "Ajustes"
    
    @selector_settings = SelectorSetting.all
    @offices = Office.all
    @delegations = Delegation.all
    @device_models = DeviceModel.all
    @devices = Device.all
    @bill_items = BillItem.all
    @bill_headers = BillHeader.all

    @section = params[:section]
    @position = case @section
      when 'offices'
        0
      when 'devices'
        1
      when 'billings'
        2
      else
        0
    end
  end
end
