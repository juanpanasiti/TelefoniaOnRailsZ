class HomeController < ApplicationController
  def index
    @lines = Line.all
    @users = Person.all
  end

  def about
  end
end
