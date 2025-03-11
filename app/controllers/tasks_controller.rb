# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_task!, except: %i[index create]
  respond_to :html, :xml, :json

  def index
    tasks = Task.all.as_json(include: { assigned_user: { only: %i[name id] } })
    render_json({ tasks: })
  end

  def show
    render_json({ task: @task, assigned_user: @task.assigned_user })
  end

  def create
    task = Task.new(task_params)
    task.save!
    render_notice("Task was successfully created")
  end

  def update
    @task.update!(task_params)
    render_notice("Task was successfully updated!")
  end

  def destroy
    @task.destroy!
    render_json
  end

  private

    def load_task!
      @task = Task.find_by!(slug: params[:slug])
    end

    def task_params
      params.require(:task).permit(:title, :assigned_user_id)
    end
end
