class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :options_for_select, only: [:new, :create, :edit, :update]
  before_action :set_has_menu
  def index
    @tasks = Task.fresh + Task.pending + Task.in_feedback + Task.finished_ok + Task.finished_fail
    @le_titule = "Tareas"
  end

  def new
    @task = Task.new
    @le_titule = "Nueva tarea"
  end
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Tarea creada.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @le_titule = "Editar tarea"
    #code
  end
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Tarea actualizada.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path, alert: 'task eliminada.' }
    end
  end

  protected
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :detail, :state, :type_task, :date_limit)
  end

  def options_for_select
    @state_options = Task.get_state_options
    @type_options = Task.get_type_options
  end

  def set_has_menu
    @has_menu = false
  end
end
