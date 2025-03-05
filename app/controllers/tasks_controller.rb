# frozen_string_literal: true

class TasksController < ApplicationController
  respond_to :html, :xml, :json

  def index
    tasks = Task.all
    render status: :ok, json: { tasks: }
  end

  def create
    task = task.new(task_params)
    task.save!
    render_notice("Task was successfully created")
  end

  private

    def task_params
      params.require(:task).permit(:title)
    end
end
