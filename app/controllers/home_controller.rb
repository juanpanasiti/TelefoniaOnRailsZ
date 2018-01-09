class HomeController < ApplicationController
  layout "new_layout", :only => [:about]
  def index
    @has_menu = true
    #sections: dashboard, lines, internals, users
    #@lines = Line.all
    #@users = Person.all
    #@section = params[:section]
    #@position = case @section
    #  when 'dashboard'
    #    0
    #  when 'lines'
    #    1
    #  when 'internals'
    #    2
    #  when 'users'
    #    3
    #  else
    #    0
    #  end
    #end
    #titles = ['Inicio','Líneas','Internos','Usuarios']
    #@le_titule = titles[@position.to_i]
  end
  def about
  end
  def dashboard
    @has_menu = true
  end
end
