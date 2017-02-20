class PeopleController < ApplicationController
  before_action :set_person, only: [:edit, :update, :destroy]
  before_action :set_form_options, only: [:new, :create, :edit, :update]
  def new
    @user = Person.new
  end
  def create
    @user = Person.new(person_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to home_index_path, notice: 'Usuario agregado correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def set_form_options
    #@office_options = Person.get_office_options
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    params.require(:person).permit(:name, :lastname, :dni, :footnote, :alert)
  end
end
