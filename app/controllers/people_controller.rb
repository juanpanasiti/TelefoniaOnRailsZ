class PeopleController < ApplicationController
  before_action :set_person, only: [:edit, :update, :destroy]
  before_action :set_form_options, only: [:new, :create, :edit, :update]

  def index
    @users = Person.all
    @le_titule = "Usuarios"
  end
  def new
    @user = Person.new
    @le_titule = "Nuevo usuario"
  end
  def create
    @user = Person.new(person_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to people_path, notice: 'Usuario agregado correctamente.' }
      else
        format.html { render :new }
      end
    end
  end
  def update
    @le_titule = "Editar #{@user.get_full_name}"
    respond_to do |format|
      if @user.update(person_params)
        format.html { redirect_to people_path, notice: 'Datos de usuario actualizados correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to people_path, alert: 'Usuario eliminado.' }
      format.json { head :no_content }
    end
  end

  private

  def set_form_options
    #@office_options = Person.get_office_options
    @office_options = Office.get_detailed_list
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @user = Person.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    params.require(:person).permit(:name, :lastname, :dni, :footnote, :alert, :office_id)
  end
end
