class HomeController < ApplicationController
  def index
    #sections: dashboard, lines, internals, users
    @lines = Line.all
    @users = Person.all
    @section = params[:section]
    @position = case @section
      when 'dashboard'
        0
      when 'lines'
        1
      when 'internals'
        2
      when 'users'
        3
      else
        0
      end
    end

  def about
  end
end
