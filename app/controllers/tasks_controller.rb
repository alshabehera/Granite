# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_task!, only: %i[show update]
  respond_to :html, :xml, :json

  def index
    tasks = Task.all
    render status: :ok, json: { tasks: }
  end

  def show
    render_json({ task: @task })
  end

  def create
    task = task.new(task_params)
    task.save!
    render_notice("Task was successfully created")
  end

  def update
    @task.update!(task_params)
    render_notice("Task was successfully updated!")
  end

  private

    def load_task!
      @task = Task.find_by!(slug: params[:slug])
    end

    def task_params
      params.require(:task).permit(:title)
    end
end
