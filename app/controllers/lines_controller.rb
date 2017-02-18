class LinesController < ApplicationController
  before_action :set_line, only: [:edit, :update, :delete]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def new
    @line = Line.new
  end
  def create
    #code
  end

  def edit
    #code
  end
  def update
    #code
  end

  def delete
    #code
  end

  protected
  def set_line
    #code
  end

  def line_params
    Line.permit(:number, :person_id, :has_inet, :state, :type_sim, :has_sms_pack, :check_date, :notes, :bill_account, :vpn_link, :limit_offnet)
  end

  def options_for_select
    @users = Person.all

  end
end
