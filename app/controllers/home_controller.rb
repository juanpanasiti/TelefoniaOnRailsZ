class HomeController < ApplicationController
  #layout "new_layout", :only => [:about]
  #def index
  # REFACTOR 09-2018
  #  @has_menu = false
  #  @le_titule = "Dashboard"
  #end
  def about
    # REFACTOR 09-2018
    @le_titule = "About"
  end
  def dashboard
    # REFACTOR 09-2018
    @le_titule = "Dashboard"
    # Líneas celulares municipales
    @lines = Line.current_lines
    @lines_for_service = @lines.for_service
    @lines_in_use = @lines.in_use
    @lines_saved = @lines.saved
    @lines_on_loan = @lines.on_loan
    @lines_check_status = @lines.check_status

    #planes activos
    @plans = Plan.all
    # Teléfonos fijos municipales
    @internals = Internal.all

    # Tareas
    @tasks = Task.all
    @tasks_new = @tasks.fresh
    @tasks_pending = @tasks.pending
    @tasks_feedback = @tasks.in_feedback
  end
end
