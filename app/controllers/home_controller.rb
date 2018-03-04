class HomeController < ApplicationController
  layout "new_layout", :only => [:about]
  def index
    @has_menu = true
  end
  def about
  end
  def dashboard
    @has_menu = true
    # Líneas celulares municipales
    @lines = Line.current_lines
    @lines_for_service = Line.for_service
    @lines_in_use = Line.in_use
    @lines_saved = Line.saved
    @lines_on_loan = Line.on_loan
    @lines_check_status = Line.check_status

    # Teléfonos fijos municipales
    @internals = Internal.all
  end
end
