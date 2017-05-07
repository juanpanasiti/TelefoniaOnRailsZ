class DelegationsController < ApplicationController
  before_action :set_delegation, only: [:edit, :update, :delete]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def new
    @delegation = Delegation.new
  end
  def create
    @delegation = Delegation.new(delegation_params)

    respond_to do |format|
      if @delegation.save
        format.html { redirect_to settings_path(section:'offices'), notice: 'Delegación creada.' }
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
      if @delegation.update(delegation_params)
        format.html { redirect_to settings_path(section:'offices'), notice: 'Delegación editada.' }
      else
        format.html { render :edit }
      end
    end
  end

  def delete
    @delegation.destroy
    respond_to do |format|
      format.html { redirect_to settings_path(section:'offices'), notice: 'Delegación eliminada.' }
    end
  end

  protected
  def set_delegation
    @delegation = Delegation.find(params[:id])
  end

  def delegation_params
    params.require(:delegation).permit(:name, :address, :footnote)
  end

  def options_for_select

  end
end
