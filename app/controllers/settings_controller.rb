class SettingsController < ApplicationController
  def index
    @selector_settings = SelectorSetting.all
    @offices = Office.all
    @delegations = Delegation.all
    @section = params[:section]
    @position = case @section
      when 'offices'
        0
      when 'device_models'
        1
      when 'billing'
        2
      else
        0
    end
  end
end
